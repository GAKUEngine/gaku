module Gaku
  class ProgramLevel < ActiveRecord::Base

    belongs_to :program
    belongs_to :level

    validates :level_id, presence: true

    def to_s
      name
    end

  end
end
