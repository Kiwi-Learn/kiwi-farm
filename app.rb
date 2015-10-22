require 'sinatra/base'

class KiwiFarmApp < Sinatra::Base
  get '/' do
    'Hello, This is Kiwi farm service. Current API version is v1. ' \
      'See Homepage at <a href="https://github.com/Kiwi-Learn/kiwi-farm">' \
      'Github repo</a>'
  end
end
