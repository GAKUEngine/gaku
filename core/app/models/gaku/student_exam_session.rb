module Gaku
  class StudentExamSession < ActiveRecord::Base
    belongs_to :exam_session
    belongs_to :student

    validates :exam_session_id, presence: true
    validates :student_id,
              presence: true,
              uniqueness: { scope: :exam_session_id }
  end
end
