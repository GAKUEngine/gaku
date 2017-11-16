module Gaku
  class ProgramSpecialty < ActiveRecord::Base
    belongs_to :program, required: false
    belongs_to :specialty, required: false

    validates :specialty, presence: true
  end
end
