module Gaku
  class ExtracurricularActivitySerializer < ActiveModel::Serializer
    attributes %i( id name created_at updated_at enrollments_count )
  end
end
