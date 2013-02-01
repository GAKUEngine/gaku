module Gaku
	class ContactType < ActiveRecord::Base

	  has_many :contacts

	  attr_accessible :name

    validates_presence_of :name

    def to_s
      name
    end

	end
end
