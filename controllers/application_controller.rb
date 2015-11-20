require 'sinatra/base'
require 'sinatra/flash'

require 'hirb'
require 'slim'

require 'httparty'


class ApplicationController < Sinatra::Base
  helpers CourseHelpers, SearchHelpers, ApplicationHelpers
  enable :sessions
  register Sinatra::Flash
  use Rack::MethodOverride

  set :views, File.expand_path('../../views', __FILE__)
  set :public_folder, File.expand_path('../../public', __FILE__)

  configure do
    Hirb.enable
    set :session_secret, 'something'
    set :api_ver, 'api/v1'
  end

  configure :development, :test do
    set :api_server, 'http://localhost:9292'
  end

  configure :production do
    set :api_server, 'https://kiwi-learn.herokuapp.com/'
  end

  configure :production, :development do
    enable :logging
  end

  api_get_root = lambda do
    'Hello there!! This is Kiwi farm service. Current API version is v1. Now we have deployed our service on Heroku. Please feel free to explore it!' \
      'See Homepage at <a href="https://github.com/Kiwi-Learn/kiwi-farm">' \
      'Github repo</a>'
  end

  api_get_info = lambda do
    content_type :json
    get_course(params[:id]).to_json
  end

  api_post_search = lambda do
    content_type :json
    begin
      req = JSON.parse(request.body.read)
    rescue
      halt 400
    end

    # query DB
    search = Search.find_by_keyword(req['keyword'])
    if search
      # if DB has this element, just redirect
      # status 201
      redirect "/api/v1/searched/#{search.id}", 303
    end

    # search website
    begin
      results = search_course(req['keyword'])
    rescue
      halt 500, 'Lookup of ShareCourse failed'
    end

    # insert
    if results.name
      search = Search.new(
        keyword: req['keyword'],
        course_name: results.name,
        course_id:results.id,
        course_url:results.url,
        course_date: results.date)

      if search.save
        status 201
        redirect "/api/v1/searched/#{search.id}", 303
      else
        halt 500, 'Error saving tutorial request to the database'
      end
    else
      # if result return nil, redirect to not found
      redirect '/api/v1/searched/notfound', 303
    end

    # search_course(req['keyword']).to_json
  end

  api_get_notfound = lambda do
    status 204
    'Course not found!'
  end

  api_get_searched = lambda do
    content_type :json
    begin
      search = Search.find(params[:id])
      keyword = search.keyword
    rescue
      halt 400
    end

    { keyword: keyword,
      course_id: search.course_id,
      course_name: search.course_name,
      course_url: search.course_url,
      course_date: search.course_date
    }.to_json
  end

  api_get_courselist = lambda do
    get_course_list().to_json
  end

  # Web API Routes
  get '/api/v1/?', &api_get_root

  get '/api/v1/info/:id.json', &api_get_info

  get '/api/v1/searched/notfound', &api_get_notfound
  get '/api/v1/searched/:id', &api_get_searched
  post '/api/v1/search', &api_post_search

  get '/api/v1/courselist', &api_get_courselist

  # Web App Views Methods
  app_get_root = lambda do
    slim :home
  end

  app_get_courses = lambda do
    @courselist = JSON.parse(get_course_list().to_json)
    slim :courses
  end

  app_get_courses_info = lambda do
    @single_course = JSON.parse(get_course(params[:id]).to_json)
    slim :course_info
  end

  app_get_search = lambda do
    slim :search
  end

  app_post_search =lambda do
    form = SearchForm.new(params)
    # logger.info form
    request_url = "#{settings.api_server}/#{settings.api_ver}/search"
    error_send(back, "Following fields are required: #{form.error_fields}") \
      unless form.valid?

    logger.info request_url
    results = CheckSearchFromAPI.new(request_url, form).call
    error_send back, 'Could not find usernames' if (results.code != 200)

    if (results.code != 200)
      flash[:notice] = 'Could not found course'
      redirect '/search'
      return nil
    end

    # course_id = results.parsed_response['course_id']
    redirect "/courses/#{results.course_id}"
  end

  # Web App Views Routes
  get '/', &app_get_root
  get '/courses', &app_get_courses
  get '/courses/:id', &app_get_courses_info
  get '/search' , &app_get_search
  post '/search' ,&app_post_search

end
