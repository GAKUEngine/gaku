module Gaku
  class SyllabusSerializer < ActiveModel::Serializer
    attributes %i( id name code description credits hours created_at updated_at )
  end
end
