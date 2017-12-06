module Gaku
  class SyllabusSerializer < ActiveModel::Serializer
    attributes %i( id name code )
  end
end
