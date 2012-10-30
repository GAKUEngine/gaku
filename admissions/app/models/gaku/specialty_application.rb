module Gaku
  class SpecialtyApplication < ActiveRecord::Base
    belongs_to :specialty

    attr_accessible :rank, :specialty_id
  end
end