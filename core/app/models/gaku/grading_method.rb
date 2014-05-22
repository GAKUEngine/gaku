module Gaku
  class GradingMethod < ActiveRecord::Base
    has_one :exam
    has_one :exam_portion
    has_one :assignment
    has_many :simple_grade_types

    has_many :grading_method_connectors

    has_many :grading_method_set_items
    has_many :grading_method_sets, through: :grading_method_set_items

    validates :name, presence: true, uniqueness: true

    @@method_list = {
        score:       Gaku::Grading::Collection::Score,
        percentage:  Gaku::Grading::Collection::Percentage #,
        # ordinal:     Gaku::Grading::Collection::Ordinal,
        # interval:    Gaku::Grading::Collection::Interval,
        # ratio:       Gaku::Grading::Collection::Ratio,
        # pass_fail:   Gaku::Grading::Collection::PassFail
    }

    validates :method, presence: true, inclusion: { in: @@method_list.keys.map(&:to_s) }

    after_initialize do
      if self.new_record?
        self.curved = false
      end
    end

    def self.method_list
      @@method_list
    end

    def to_s
      name
    end
  end
end
