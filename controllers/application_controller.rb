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
    search_course(req['keyword']).to_json
  end

  get_courselist = lambda do
    get_course_list().to_json
  end


  get '/', &get_root

  get '/api/v1/info/:id.json', &get_info

  post '/api/v1/search', &post_search
  
  get '/api/v1/courselist', &get_courselist
end
