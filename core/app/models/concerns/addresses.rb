module Addresses
  extend ActiveSupport::Concern

  included do
    has_many :addresses, as: :addressable
    has_one :primary_address, -> { where(primary: true) }, class_name: 'Gaku::Address', as: :addressable

    # def primary_address
    #   addresses.where(primary: true).first
    # end

    def address_widget
      if primary_address
        "#{primary_address.city}, " \
          "#{primary_address.address1}"
      end
    end
  end
end
