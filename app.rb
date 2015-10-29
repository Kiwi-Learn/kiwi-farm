require 'sinatra/base'
require_relative './model/courses'

class KiwiFarmApp < Sinatra::Base
  helpers do
    def get_course(id)
      Course.new(id, nil)
    rescue
      halt 404
    end

    def search_course(keyword)
      Course.new(nil, keyword)
    rescue
      halt 404
    end

    def get_course_list()
      CourseList.new()
    rescue
      halt 404
    end
  end

  get '/' do
    'Hello, This is Kiwi farm service. Current API version is v1. Now we have deployed our service on Heroku. Please feel free to explore it!' \
      'See Homepage at <a href="https://github.com/Kiwi-Learn/kiwi-farm">' \
      'Github repo</a>'
  end

  get '/api/v1/info/:id.json' do
    content_type :json
    get_course(params[:id]).to_json
  end

  post '/api/v1/search' do
    content_type :json
    begin
      req = JSON.parse(request.body.read)
    rescue
      halt 400
    end
    search_course(req['keyword']).to_json
  end

  get '/api/v1/courselist' do
    get_course_list().to_json
  end
end
