module Gaku
  class ExamSession < ActiveRecord::Base
    belongs_to :exam

    has_many :student_exam_sessions
    has_many :students, through: :student_exam_sessions

    validates :exam_id, presence: true

    def to_s
      name
    end
  end
end
