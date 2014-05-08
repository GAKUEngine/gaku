module Trashable
  extend ActiveSupport::Concern

  included do
    default_scope -> { where(deleted: false) }
    scope :deleted, -> { where(deleted: true) }

    def soft_delete
      update_attribute(:deleted, true)
    end

    def recover
      update_attribute(:deleted, false)
    end
  end

end
