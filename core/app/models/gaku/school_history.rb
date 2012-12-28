module Gaku
  class SchoolHistory < ActiveRecord::Base
    belongs_to :school
    belongs_to :student
    belongs_to :admission, :foreign_key => :admission_id

    attr_accessible :school_id, :student_id, :admission_id
  end
end