module Gaku
  class SimpleGrade < ActiveRecord::Base

    belongs_to :student
    belongs_to :school

    validates :name, :student_id, presence: true

    def to_s
      name
    end

  end
end
