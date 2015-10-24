require_relative 'spec_helper'
require 'json'

describe 'Getting the root of the service' do
  it 'Should return ok' do
    get '/'
    last_response.must_be :ok?
    last_response.body.must_match(/Kiwi farm service/)
  end
end

describe 'Getting the detail of course' do
  it 'Should return ok' do
    get '/api/v1/courses/info/MA02004'
    last_response.must_be :ok?
    last_response.body.must_match(/"id":"MA02004"/)
  end
end
