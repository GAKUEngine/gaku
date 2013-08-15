module Gaku
  class ProgramSpecialty < ActiveRecord::Base

    belongs_to :program
    belongs_to :specialty

    validates :specialty, :program, presence: true

  end
end
