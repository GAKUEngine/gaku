module Gaku
  module Trashable
    extend ActiveSupport::Concern

    included do
      default_scope -> { where(is_deleted: false) }
      scope :deleted, -> { where(is_deleted: true) }

      def soft_delete
        self.is_deleted = true
        save
      end

    end

  end
end
