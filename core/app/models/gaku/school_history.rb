module Gaku
  class SchoolHistory < ActiveRecord::Base
    belongs_to :school
    belongs_to :student

    attr_accessible :school_id, :student_id
  end
end
