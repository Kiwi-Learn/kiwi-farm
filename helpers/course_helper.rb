module CourseHelpers
  def get_course(id)
    Course.new(id, nil)
  rescue => e
    logger.info e
    halt 404
  end
  
  def get_course_list()
    CourseList.new()
  rescue => e
    logger.info e
    halt 404
  end
end
