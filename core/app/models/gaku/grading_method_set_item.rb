module Gaku
  class GradingMethodSetItem < ActiveRecord::Base
    belongs_to :grading_method
    belongs_to :grading_method_set
    attr_accessible :order, :grading_method_id, :grading_method_set_id
  end
end
