require 'virtus'

##
# Value object for results from searching a tutorial set for missing badges
class SearchResult
  include Virtus.model

  attribute :code
  attribute :keyword
  attribute :course_name
  attribute :course_id
  attribute :course_url
  attribute :course_date

  def to_json
    to_hash.to_json
  end
end

##
# Service object to check tutorial request from API
class CheckSearchFromAPI
  def initialize(api_url, form)
    @api_url = api_url
    params = form.attributes.delete_if { |_, value| value.blank? }
    @options =  {
      body: params.to_json,
      headers: { 'Content-Type' => 'application/json' }
    }
  end

  def call
    results = HTTParty.post(@api_url, @options)
    search_results = SearchResult.new(results)
    search_results.code = results.code
    search_results.course_id = results.parsed_response['course_id']
    search_results
  end
end
