require_relative 'spec_helper'
require 'json'

describe 'Searching course' do
  before do
    Search.delete_all
  end

  it 'Should return course info' do
    header = { 'CONTENT_TYPE' => 'application/json' }
    body = {
      keyword: 'program'
    }

    # Check redirect URL from post request
    post '/api/v1/search', body.to_json, header
    last_response.must_be :redirect?
    next_location = last_response.location
    next_location.must_match %r{api\/v1\/searched\/\d+}

    # Check if request parameters are stored in ActiveRecord data store
    ser_id = next_location.scan(%r{searched\/(\d+)}).flatten[0].to_i
    save_search = Search.find(ser_id)
    save_search[:keyword].must_equal body[:keyword]

    VCR.use_cassette('search_good') do
      follow_redirect!
    end
    last_request.url.must_match %r{api\/v1\/searched\/\d+}

    # Check if redirected response has results
    JSON.parse(last_response.body).count.must_be :>, 0
  end
end
