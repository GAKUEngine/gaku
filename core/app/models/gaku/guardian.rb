module Gaku
  class Guardian < ActiveRecord::Base

    include Addresses, Contacts

    belongs_to :user
    has_and_belongs_to_many :students, :join_table => :gaku_guardians_students

    validates_presence_of :name, :surname

    attr_accessible :name, :surname, :name_reading, :surname_reading, :relationship

  end
end
