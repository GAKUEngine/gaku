module Gaku
  class StudentAchievement < ActiveRecord::Base
    belongs_to :student
    belongs_to :achievement
  end
end