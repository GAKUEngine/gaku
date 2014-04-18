module Gaku
  class ExamSchedule < ActiveRecord::Base
    belongs_to :exam_portion
    belongs_to :schedule
    belongs_to :course

    validates :exam_portion, :schedule, :course, presence: true
  end
end
