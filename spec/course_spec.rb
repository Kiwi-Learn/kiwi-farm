require_relative 'spec_helper'
require 'json'

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

describe 'Course List' do
  it 'Should return course list' do
    VCR.use_cassette('courselist') do
      get '/api/v1/courselist'
    end
    last_response.must_be :ok?
  end
end
