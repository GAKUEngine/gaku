module Gaku
  class ProgramSpecialty < ActiveRecord::Base

    belongs_to :program
    belongs_to :specialty

    validates :specialty_id, presence: true

  end
end
