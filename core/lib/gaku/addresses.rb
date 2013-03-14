module Gaku
  module Addresses
    extend ActiveSupport::Concern

    included do
      has_many :addresses, as: :addressable

      def primary_address
        self.addresses.where(:is_primary => true).first
      end
    end

  end
end
