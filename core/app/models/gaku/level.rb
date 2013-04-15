module Gaku
  class Level < ActiveRecord::Base

    belongs_to :school

    has_many :program_levels
    has_many :programs, :through => :program_levels

    attr_accessible :name

    validates :name, :presence => true

    def to_s
      name
    end

  end
end
