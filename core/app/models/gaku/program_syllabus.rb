module Gaku
  class ProgramSyllabus < ActiveRecord::Base
    belongs_to :program
    belongs_to :syllabus
    belongs_to :level

    validates :syllabus, presence: true
  end
end
