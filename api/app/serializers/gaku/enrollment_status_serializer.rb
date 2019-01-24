module Gaku
  class EnrollmentStatusSerializer < ActiveModel::Serializer
    attributes %i( id code active immutable )
  end
end
