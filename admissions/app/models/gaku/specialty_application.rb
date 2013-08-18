module Gaku
  class SpecialtyApplication < ActiveRecord::Base

    belongs_to :specialty
    belongs_to :admission

  end
end
