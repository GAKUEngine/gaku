module Gradable
  extend ActiveSupport::Concern

  included do
    has_many :grading_method_connectors, as: :gradable
    has_many :grading_methods, through: :grading_method_connectors
  end

  def use_primary_grading_method_set
    if Gaku::GradingMethodSet.primary
      grading_methods << Gaku::GradingMethodSet.primary.grading_methods
    end
  end
end
