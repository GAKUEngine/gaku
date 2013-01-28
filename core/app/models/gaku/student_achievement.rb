module Gaku
  class StudentAchievement < ActiveRecord::Base
    belongs_to :student
    belongs_to :achievement

    attr_accessible :achievement_id

    validates_presence_of :achievement_id
  end
end