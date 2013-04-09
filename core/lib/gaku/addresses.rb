module Gaku
  module Addresses
    extend ActiveSupport::Concern

    included do
      has_many :addresses, as: :addressable

      def get_primary_address
        self.addresses.where(:is_primary => true).first
      end

      def address_widget
        "#{self.get_primary_address.city}, #{self.get_primary_address.address1}" if self.get_primary_address
      end
    end

  end
end
