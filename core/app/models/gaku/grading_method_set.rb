module Gaku
  class GradingMethodSet < ActiveRecord::Base

    has_many :grading_method_set_items, -> { order(:position) }
    has_many :grading_methods, through: :grading_method_set_items

    validates :name, presence: true, uniqueness: true

    before_save :ensure_first_is_primary, on: :create

    def make_primary
      GradingMethodSet.where(['id != ?', id]).update_all({ primary: false })
      self.update_attribute(:primary, true)
    end

    def items
      self.grading_method_set_items
    end

    private

    def ensure_first_is_primary
      self.primary = true if GradingMethodSet.all.empty?
    end

    def update_items_positions(id, index)
      self.grading_method_set_items.update_all( { position: index }, { id: id } )
    end

  end
end
