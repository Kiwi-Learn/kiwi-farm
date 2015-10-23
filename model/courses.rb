require 'kiwicourse'
require 'json'


class Course
  def []=(id, name, url, date)
    @course ||= {}
    @course[id] = {
      'id' => id,
      'name' => name,
      'url' => url,
      'date' => date
    }
  end
  def to_json
    @course.map do |id, name, url, date|
      {
        'id' => id,
        'name' => name,
        'url' => url,
        'date' => date
      }
    end.to_json
  end
end

##
# Stores course name and id information in a jsonifiable list
#
# Example:
#   b = CourseList.new
#   b['電腦安全概論'] = 'CS04001'
#   puts b.to_json
# class CourseList
#   def []=(name, id)
#     @courses ||= {}
#     @courses[name] = id
#   end
#
#   def to_json
#     @courses.map do |name, id, url, date|
#       {
#         'name' => name,
#         'id' => id,
#         'url' => url,
#         'date' => date
#       }
#     end.to_json
#   end
# end

# 'name' => name[index],
# 'date' => date[index],
# 'url' => url[index],
# 'id' => course_id[index]
class ShareCourses
  attr_reader :type, :courses
  def initialize(type = 'course')
    @type = type
    @courses = load_courses
  end

  def to_json
    { 'id' => @username, 'type' => @type, 'badges' => @badges }.to_json
  end

  private

  def load_courses
    courses = CourseList.new
    KiwiScraper::ShareCourse.new.courses_id_to_all_mapping.each do |course|
      ##
    end
  end
end
