require 'sinatra/base'
require_relative './model/courses'

class KiwiFarmApp < Sinatra::Base
  helpers do
    def get_course(id)
      Course.new(id, name=nil)
    rescue
      halt 404
    end
  end

  get '/' do
    'Hello, This is Kiwi farm service. Current API version is v1. ' \
      'See Homepage at <a href="https://github.com/Kiwi-Learn/kiwi-farm">' \
      'Github repo</a>'
  end

  get '/api/v1/courses/info/:id' do
    content_type :json
    get_course(params[:id]).to_json
  end

end
