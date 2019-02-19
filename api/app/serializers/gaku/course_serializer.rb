module Gaku
  class CourseSerializer < ActiveModel::Serializer
    attributes %i( id name code notes_count students_count faculty_id
      syllabus_id class_group_id enrollments_count
    )
  end
end
