module Gaku
  class GradingMethodSetItem < ActiveRecord::Base
    belongs_to :grading_method
    belongs_to :grading_method_set
    attr_accessible :order, :grading_method_id, :grading_method_set_id

    validates :grading_method_id, presence: true, uniqueness: { scope: :grading_method_set_id, message: I18n.t(:'grading_method_set_item.already') }

  end
end
