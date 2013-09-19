module Trashable
  extend ActiveSupport::Concern

  included do
    default_scope -> { where(is_deleted: false) }
    scope :deleted, -> { where(is_deleted: true) }

    def soft_delete
      self.is_deleted = true
      save
    end

    def recover
      self.is_deleted = false
      save
    end
  end

end

