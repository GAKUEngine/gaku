module Gaku
  class ProgramLevel < ActiveRecord::Base
    belongs_to :program
    belongs_to :level

    validates :level, presence: true
  end
end
