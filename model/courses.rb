require 'kiwicourse'
require 'json'

class Course
  def []=(id)
    @course ||= {}
    @course[id] = load_course(id)
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
  def load_course(id)
    KiwiScraper::ShareCourse.new.courses_id_to_all_mapping[id]
  end
end
