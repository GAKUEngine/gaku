module Gaku
  class UserSerializer < ActiveModel::Serializer
    attributes :id, :username, :email, :disabled, :disabled_until
    has_many :roles
  end
end
