class ExamScore < ActiveRecord::Base
  belongs_to :student
  belongs_to :exam
end
