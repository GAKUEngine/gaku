module Gaku
  class ContactType < ActiveRecord::Base
    has_many :contacts

    validates :name, presence: true, uniqueness: { case_sensitive: false }

    def to_s
      name
    end
  end
end
