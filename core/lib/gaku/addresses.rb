module Gaku
  module Addresses
    extend ActiveSupport::Concern

    included do
      has_many :addresses, as: :addressable

      def primary_address
        self.addresses.where(:is_primary => true).first
      end

      def address_widget
        "#{self.primary_address.city}, #{self.primary_address.address1}" if self.primary_address
      end
    end

  end
end
