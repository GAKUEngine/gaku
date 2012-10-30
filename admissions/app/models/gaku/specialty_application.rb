module Gaku
  class SpecialtyApplication < ActiveRecord::Base
    belongs_to :specialty
    belongs_to :admission

    attr_accessible :rank, :specialty_id, :admission_id
  end
end