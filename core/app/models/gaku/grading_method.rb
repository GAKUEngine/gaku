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

    Types = %w( score percentage ordinal interval )

    validates :grading_type, presence: true, inclusion: { in: Types }

    serialize :criteria, Hash

    Types.each do |type|
      define_method "#{type}?" do
        grading_type == type
      end
    end

    def to_s
      name
    end
  end
end
