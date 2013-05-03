module Gaku
  class GradingMethodSet < ActiveRecord::Base
    attr_accessible :display_deviation, :display_rank, :name, :primary, :rank_order

    has_many :grading_method_set_items
    has_many :grading_methods, through: :grading_method_set_items

    validates :name, presence:true
  end
end
