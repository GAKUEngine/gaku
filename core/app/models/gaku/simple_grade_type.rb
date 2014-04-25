module Gaku
  class SimpleGradeType < ActiveRecord::Base
    has_many :simple_grades
    belongs_to :school
    belongs_to :grading_method

    validates :name, presence: true

    def to_s
      name
    end
  end
end
