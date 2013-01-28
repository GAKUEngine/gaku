module Gaku
  class StudentAchievement < ActiveRecord::Base
    belongs_to :student
    belongs_to :achievement

    attr_accessible :achievement_id

    validate_presence_of :achievement_id
  end
end