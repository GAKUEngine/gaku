module Gaku
  class GradingMethodSet < ActiveRecord::Base
    attr_accessible :display_deviation, :display_rank, :name, :is_primary, :rank_order

    has_many :grading_method_set_items, -> { order(:position) }
    has_many :grading_methods, through: :grading_method_set_items

    validates :name, presence:true, uniqueness: true

    before_save :ensure_first_is_primary, on: :create


    def make_primary
      GradingMethodSet.update_all( { is_primary: false }, ['id != ?', id] )
      self.update_attribute :is_primary, true
    end


    def ensure_first_is_primary
      self.is_primary = true if Gaku::GradingMethodSet.all.empty?
    end

    def update_items_positions(id, index)
      self.grading_method_set_items.update_all( { position: index }, { id: id } )
    end

  end
end
