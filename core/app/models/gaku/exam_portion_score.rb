module Gaku
  class ExamPortionScore < ActiveRecord::Base
    belongs_to :student
    belongs_to :exam_portion

    has_many :attendances, as: :attendancable
  end
end
