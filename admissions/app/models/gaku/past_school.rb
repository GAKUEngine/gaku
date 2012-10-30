module Gaku
  class PastSchool < ActiveRecord::Base
    belongs_to :school
    has_many :achievements
    has_many :simple_grades

    attr_accessible :school_id
  end
end