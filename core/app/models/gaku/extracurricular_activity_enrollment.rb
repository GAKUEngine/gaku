module Gaku
  class ExtracurricularActivityEnrollment < ActiveRecord::Base
    belongs_to :extracurricular_activity
    belongs_to :student
    has_many :roles

    attr_accessible :extracurricular_activity_id, :student_id

    validates :student_id,
              uniqueness: { scope: :extracurricular_activity_id, message: "Already enrolled to the extracurricular activity!" }
    validates_presence_of :extracurricular_activity_id, :student_id
  end
end
