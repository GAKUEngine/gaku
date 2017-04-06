
module Gaku
  class ClassGroupSerializer < ActiveModel::Serializer
    attributes %i( id name grade homeroom notes_count faculty_id created_at updated_at enrollments_count )
  end
end
