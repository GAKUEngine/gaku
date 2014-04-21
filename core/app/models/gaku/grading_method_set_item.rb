module Gaku
  class GradingMethodSetItem < ActiveRecord::Base
    belongs_to :grading_method
    belongs_to :grading_method_set

    validates :grading_method_set_id, :grading_method_id, presence: true

    validates :grading_method_id,
      uniqueness: {
        scope: :grading_method_set_id,
        message: I18n.t(:'grading_method_set_item.already')
      }

    before_create :proper_position
    after_destroy :refresh_positions

    private

    def proper_position
      return unless grading_method_set
      self.position = grading_method_set.grading_method_set_items.count
    end

    def refresh_positions
      items = grading_method_set.grading_method_set_items
      items.pluck(:id).each_with_index do |id, index|
        items.update_all(position: index, id: id)
      end
    end
  end
end
