module Gaku
  class PeriodMethodAssociation < ActiveRecord::Base

    belongs_to :admission_period
    belongs_to :admission_method

    attr_accessible :admission_period_id, :admission_method_id

    validates :admission_method_id, :uniqueness => {:scope => :admission_period_id}
  end
end
