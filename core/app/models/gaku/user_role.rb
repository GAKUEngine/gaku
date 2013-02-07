module Gaku
  class UserRole < ActiveRecord::Base
    belongs_to :user
    belongs_to :role

    attr_accessible :user_id, :role_id
    validates_presence_of :user_id, :role_id
  end
end
