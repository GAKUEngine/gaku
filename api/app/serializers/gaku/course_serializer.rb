module Gaku
  class CourseController < ActiveModel::Serializer
    attributes %i( id name code notes_count students_count faculty_id
      syllabus_id class_group_id created_at updated_at enrollments_count
    )
  end
end
