require 'sinatra/base'

class ApplicationController < Sinatra::Base
  helpers CourseHelpers, SearchHelpers

  configure :production, :development do
    enable :logging
  end

  get_root = lambda do
    'Hello there!! This is Kiwi farm service. Current API version is v1. Now we have deployed our service on Heroku. Please feel free to explore it!' \
      'See Homepage at <a href="https://github.com/Kiwi-Learn/kiwi-farm">' \
      'Github repo</a>'
  end

  get_info = lambda do
    content_type :json
    get_course(params[:id]).to_json
  end

  post_search = lambda do
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
      # logger.info 'before search ' + req['keyword']
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

  get_notfound = lambda do
    'Course not found!'
  end

  get_searched = lambda do
    content_type :json
    begin
      search = Search.find(params[:id])
      keyword = search.keyword
      logger.info({id: search.id, keyword: keyword}.to_json)
    rescue
      halt 400
    end

    { keyword: keyword,
      courese_id: search.course_id,
      course_name: search.course_name,
      course_url: search.course_url,
      course_date: search.course_date
    }.to_json
  end

  get_courselist = lambda do
    get_course_list().to_json
  end

  get '/', &get_root

  get '/api/v1/info/:id.json', &get_info

  get '/api/v1/searched/notfound', &get_notfound
  get '/api/v1/searched/:id', &get_searched
  post '/api/v1/search', &post_search

  get '/api/v1/courselist', &get_courselist
end
