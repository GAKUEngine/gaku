module Gaku
  class ExamPortionScoreSerializer < ActiveModel::Serializer
    attributes %i( id score exam_portion_id student_id)
  end
end
