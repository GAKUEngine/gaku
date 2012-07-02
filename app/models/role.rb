class Role < ActiveRecord::Base
  belongs_to :class_group_enrollment
  
  attr_accessible :name, :class_group_enrollment_id
end
