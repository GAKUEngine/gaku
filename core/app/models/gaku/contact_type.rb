module Gaku
	class ContactType < ActiveRecord::Base
	  has_many :contacts

	  attr_accessible :name, :contacts, :contacts_attributes, :guardian_id

	  accepts_nested_attributes_for :contacts, :allow_destroy => true

    validates_presence_of :name
	end
end
