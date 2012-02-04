class Student < ActiveRecord::Base
  has_many :classes, :through => :class_enrollement
end
