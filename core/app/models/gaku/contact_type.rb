module Gaku
  class ContactType < ActiveRecord::Base

    has_many :contacts

    validates :name, presence: true

    def to_s
      name
    end

  end
end
