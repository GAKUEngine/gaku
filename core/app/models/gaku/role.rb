module Gaku
  class Role < ActiveRecord::Base
    has_many :user_roles
    has_many :users, through: :user_roles

    validates :name, presence: true, uniqueness: { case_sensitive: false }

    before_save :ensure_name_downcase

    def to_s
      name
    end

    private

    def ensure_name_downcase
      self.name = self.name.downcase
    end
  end
end
