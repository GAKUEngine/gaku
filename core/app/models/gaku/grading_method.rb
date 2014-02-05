module Gaku
  class GradingMethod < ActiveRecord::Base

    has_one :exam
    has_one :exam_portion
    has_one :assignment
    has_many :simple_grade_types

    has_many :grading_method_set_items
    has_many :grading_method_sets, through: :grading_method_set_items

    validates :name, presence: true, uniqueness: true

    @@method_list = { score:       Gaku::GradingMethods::Score,
        percentage:  Gaku::GradingMethods::Percentage,
        ordinal:     Gaku::GradingMethods::Ordinal,
        interval:    Gaku::GradingMethods::Interval,
        ratio:       Gaku::GradingMethods::Ratio,
        pass_fail:   Gaku::GradingMethods::PassFail
    }

    validates :method, presence: true, inclusion: { in: @@method_list.keys.map(&:to_s) }

    def self.method_list
      @@method_list
    end

    def to_s
      name
    end

  end
end
