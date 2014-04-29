module Gaku
  class Faculty < ActiveRecord::Base
    include Addresses, Contacts

    has_many :school_roles, as: :school_rolable
    has_many :students
    has_many :class_groups
    has_many :courses
  end
end
