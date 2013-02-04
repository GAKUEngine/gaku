module Gaku
	class Role < ActiveRecord::Base
	  belongs_to :class_group_enrollment
    belongs_to :extracurricular_activity_enrollment
	  belongs_to :faculty

	  attr_accessible :name, :class_group_enrollment_id, :extracurricular_activity_enrollment_id
	end
end
