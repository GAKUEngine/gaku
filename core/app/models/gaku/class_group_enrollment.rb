module Gaku
	class ClassGroupEnrollment < ActiveRecord::Base
	  belongs_to :class_group
	  belongs_to :student
	  has_many :roles

	  attr_accessible :seat_number, :roles, :class_group_id, :student_id

	  validates :student_id,
              uniqueness: { scope: :class_group_id, message: "Already enrolled to the class group!" }
		validates_presence_of :class_group_id
	end
end
