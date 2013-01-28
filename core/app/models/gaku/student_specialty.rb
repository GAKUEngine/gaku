module Gaku
	class StudentSpecialty < ActiveRecord::Base
		belongs_to :specialty
	  belongs_to :student

	  attr_accessible :student_id, :specialty_id , :is_major

    validates :student_id, :uniqueness => {:scope => :specialty_id, :message => "Already added specialty"}

    validates_presence_of :specialty_id

    scope :ordered, order('is_major desc')


  end
end
