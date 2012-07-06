class Role < ActiveRecord::Base
  belongs_to :class_group_enrollment
  belongs_to :faculty
  
  attr_accessible :name, :class_group_enrollment_id
end
