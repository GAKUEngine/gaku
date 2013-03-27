module Gaku
  class Guardian < ActiveRecord::Base

    include Person, Addresses, Contacts, Picture

    belongs_to :user
    has_many :student_guardians, :dependent => :destroy
    has_many :students, :through => :student_guardians

    attr_accessible :relationship
  end
end
