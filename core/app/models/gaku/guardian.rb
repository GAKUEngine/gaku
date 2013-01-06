module Gaku
  class Guardian < ActiveRecord::Base
    belongs_to :user
    has_many :guardian_addresses
    has_many :addresses, :through => :guardian_addresses
    has_and_belongs_to_many :students, :join_table => :gaku_guardians_students
    has_many :contacts

    validates_presence_of :name, :surname

    attr_accessible :name, :surname, :name_reading, :surname_reading, :relationship, :contacts, :contacts_attributes
    accepts_nested_attributes_for :contacts, :allow_destroy => true

    def primary_contact
    	contacts.where(:is_primary => true).first
    end

    def primary_address
    	guardian_addresses.where(:is_primary => true).first.address rescue nil
    end
    
  end
end
