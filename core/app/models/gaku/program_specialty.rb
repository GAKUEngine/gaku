module Gaku
  class ProgramSpecialty < ActiveRecord::Base
    belongs_to :program
    belongs_to :specialty

    # attr_accessible :specialty_id, :program_id

    validates_presence_of :specialty_id

  end
end
