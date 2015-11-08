module SearchHelpers
  def search_course(keyword)
    Course.new(nil, keyword)
  rescue
    halt 404
  end
end
