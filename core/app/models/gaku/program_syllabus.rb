module Gaku
  class ProgramSyllabus < ActiveRecord::Base

    belongs_to :program
    belongs_to :syllabus
    belongs_to :level

    validates :syllabus, :program, :level, presence: true

  end
end
