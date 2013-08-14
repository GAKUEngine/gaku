module Gaku
  class ExtracurricularActivityEnrollment < ActiveRecord::Base
    belongs_to :extracurricular_activity
    belongs_to :student
    has_many :roles

    validates :student_id,
              uniqueness: {
                            scope: :extracurricular_activity_id,
                            message: I18n.t(:'extracurricular_activity.already_enrolled')
                          }
    validates :extracurricular_activity_id, :student_id, presence: true
  end
end
