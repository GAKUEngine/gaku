module Gaku
  class ExamSerializer < ActiveModel::Serializer
    attributes %i( id name )
  end
end
