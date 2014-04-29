module Gaku
  class ContactType < ActiveRecord::Base
    has_many :contacts

    validates :name, presence: true, uniqueness: true

    def to_s
      name
    end
  end
end
