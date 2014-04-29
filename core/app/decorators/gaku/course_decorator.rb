module Gaku
  class CourseDecorator < Draper::Decorator
    decorates 'Gaku::Course'
    delegate_all

    def code_with_syllabus_name
      if object.syllabus_name
        "#{object.syllabus_name}-#{object.code}"
      else
        object.code
      end
    end
  end
end
