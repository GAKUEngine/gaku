module Gaku
  class ProgramSpecialty < ActiveRecord::Base
    belongs_to :program
    belongs_to :specialty
  end
end
