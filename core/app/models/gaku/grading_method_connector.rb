module Gaku
  class GradingMethodConnector < ActiveRecord::Base
    belongs_to :grading_method
    belongs_to :gradable, polymorphic: true

    validates :grading_method_id, :gradable_id, :gradable_type, presence: true

    validates :gradable_type,
      inclusion: { in: %w(Gaku::Exam Gaku::Course),
                   message: "%{value} is not a valid" }

      validates :grading_method_id, uniqueness: { scope: [:gradable_type, :gradable_id] }

      default_scope { order('position ASC') }

      before_create :proper_position
      after_destroy :refresh_positions

      private

      def proper_position
        self.position = gradable.grading_method_connectors.count if gradable
      end

      def refresh_positions
        gradable.grading_method_connectors.each_with_index do |id, index|
          gradable.grading_method_connectors.where(id: id).update_all(position: index)
        end
      end
  end
end
