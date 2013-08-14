module Gaku
  class Assignment < ActiveRecord::Base
    belongs_to :syllabus
    belongs_to :grading_method

    validates :name, presence: true
    validates_associated :syllabus, :grading_method
  end
end
