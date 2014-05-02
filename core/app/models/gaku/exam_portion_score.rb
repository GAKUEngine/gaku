module Gaku
  class ExamPortionScore < ActiveRecord::Base
    belongs_to :student
    belongs_to :exam_portion

    has_many :attendances, as: :attendancable

    validates :student, :exam_portion, presence: true
  end
end
