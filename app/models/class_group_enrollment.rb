class ClassGroupEnrollment < ActiveRecord::Base
  belongs_to :class_group
  belongs_to :student
  has_many :roles

  attr_accessible :roles
end