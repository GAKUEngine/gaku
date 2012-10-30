module Gaku
  class PastSchool < ActiveRecord::Base
    belongs_to :school
    belongs_to :admission
    has_many :achievements
    has_many :simple_grades

    attr_accessible :school_id
  end
end