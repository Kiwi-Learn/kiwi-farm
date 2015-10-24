require 'kiwicourse'
require 'json'
require 'digest'
require 'fuzzy_match'

# Example:
# cl = CourseList()
# puts cl.to_json

class CourseList
  attr_reader :course_list
  def initialize
    @course_list = load_course_list
  end

  def to_json
    @course_list.to_json
  end

  private
  
  def load_course_list
    sc = KiwiScraper::OfflineCourses.new.get_instance
    # return all course list in hash 
  end
end

# Example:
# c = Course.new(id=nil, name='網路安全')
# puts c.to_json

class Course
  attr_reader :id, :name, :url, :date
  def initialize(id=nil, name=nil)
    if id.nil?
      @course = load_course_by_name(name)
    else
      @course = load_course_by_id(id)
    end
    @id = @course['id']
    @name = @course['name']
    @url = @course['url']
    @date = @course['date']
  end

  def to_json
    {'id' => @id, 'name' => @name, 'url' => @url, 'date' => @date}.to_json
  end

  private

  def load_course_by_id(id)
    sc = KiwiScraper::OfflineCourses.new.get_instance
    sc.courses_id_to_all_mapping[id]
  end

  def load_course_by_name(name)
    sc = KiwiScraper::OfflineCourses.new.get_instance
    result = FuzzyMatch.new(sc.course_name).find(name)
    input_key = Digest::SHA256.digest result
    id = sc.courses_name_to_id_mapping[input_key]
    sc.courses_id_to_all_mapping[id]
  end
end
