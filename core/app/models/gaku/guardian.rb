module Gaku
  class Guardian < ActiveRecord::Base
    belongs_to :user

    has_many :contacts, as: :contactable
    has_many :addresses, as: :addressable

    has_and_belongs_to_many :students, :join_table => :gaku_guardians_students

    validates_presence_of :name, :surname

    attr_accessible :name, :surname, :name_reading, :surname_reading, :relationship
    accepts_nested_attributes_for :contacts, :allow_destroy => true

    def primary_contact
      self.contacts.where(:is_primary => true).first
    end

  end
end
