module Gaku
  class UserRole < ActiveRecord::Base
    belongs_to :user
    belongs_to :role

    validates :user, uniqueness: { scope: :role, message: 'role already exists' }
  end
end
