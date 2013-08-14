module Gaku
  class StudentAchievement < ActiveRecord::Base

    belongs_to :student
    belongs_to :achievement

    validates :achievement_id, :student_id, presence: true

  end
end
