module Gaku
  class EnrollmentStatusSerializer < ActiveModel::Serializer
    attributes :id, :code, :active, :immutable
  end
end
