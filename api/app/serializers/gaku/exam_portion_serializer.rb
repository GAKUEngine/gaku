module Gaku
  class ExamPortionSerializer < ActiveModel::Serializer
    attributes %i( id name max_score exam_id )
  end
end
