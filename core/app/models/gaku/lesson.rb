module Gaku
  class Lesson < ActiveRecord::Base
    belongs_to :lesson_plan
    has_many :attendances, as: :attendancable

    validates :lesson_plan, presence: true
  end
end
