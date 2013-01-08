module Gaku
  class GuardianAddress < ActiveRecord::Base
    belongs_to :guardian
    belongs_to :address

    attr_accessible :guardian_id, :address_id, :is_primary

    before_save :ensure_primary, :on => :create

    def make_primary
      self.guardian.guardian_addresses.update_all('is_primary = false', "id <> #{self.id}")
      self.is_primary = true
      self.save
    end

    private

    def ensure_primary
      if self.guardian.addresses.blank?
        self.is_primary = true
      end
    end

  end
end
