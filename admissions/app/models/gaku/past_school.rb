module Gaku
  class PastSchool < ActiveRecord::Base
    belongs_to :school

    attr_accessible :school_id
  end
end