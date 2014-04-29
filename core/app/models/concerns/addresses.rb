module Addresses
  extend ActiveSupport::Concern

  included do
    has_many :addresses, as: :addressable

    def get_primary_address
      addresses.where(primary: true).first
    end

    def address_widget
      "#{get_primary_address.city}, " \
        "#{get_primary_address.address1}" if get_primary_address
    end
  end
end
