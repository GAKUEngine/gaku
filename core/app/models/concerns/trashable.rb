module Trashable
  extend ActiveSupport::Concern

  included do
    default_scope -> { where(is_deleted: false) }
    scope :deleted, -> { where(is_deleted: true) }

    def soft_delete
      update_attribute(:is_deleted, true)
    end

    def recover
      update_attribute(:is_deleted, false)
    end
  end

end