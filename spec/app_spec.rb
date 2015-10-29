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
    VCR.use_cassette('info') do  
      get '/api/v1/info/MA02004.json'
    end
    last_response.must_be :ok?
    last_response.body.must_match(/"id":"MA02004"/)
  end

  it 'should return 404 for unknown course id' do
    VCR.use_cassette('info_empty') do  
      get "/api/v1/info/#{random_str(7)}.json"
    end
    last_response.must_be :not_found?
  end
end

describe 'Searching course' do
  it 'Should return course info' do
    header = { 'CONTENT_TYPE' => 'application/json' }
    body = {
      'keyword' => 'program'
    }
    VCR.use_cassette('search') do
      post '/api/v1/search', body.to_json, header
    end
    last_response.must_be :ok?
    last_response.body.must_match(/"id":"CS01007"/)
  end
end

describe 'Course List' do
  it 'Should return course list' do
    VCR.use_cassette('courselist') do
      get '/api/v1/courselist'
    end
    last_response.must_be :ok?
  end
end
