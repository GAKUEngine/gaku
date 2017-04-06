module Gaku
  class ExamSessionSerializer < ActiveModel::Serializer
    attributes %i( id session_time name exam_id session_start enrollments_count )
  end
end
