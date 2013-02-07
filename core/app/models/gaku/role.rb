module Gaku
	class Role < ActiveRecord::Base

    has_many :user_roles
    has_many :roles, :through => :user_roles

	  belongs_to :class_group_enrollment
    belongs_to :extracurricular_activity_enrollment
	  belongs_to :faculty

    validates :name, presence: true, uniqueness: true

	  attr_accessible :name, :class_group_enrollment_id, :extracurricular_activity_enrollment_id
	end
end
