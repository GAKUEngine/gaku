FactoryBot.define do
  factory :address, class: Gaku::Address do
    address1 { FFaker::Address.street_address }
    address2 { FFaker::Address.street_address }
    city     { FFaker::Address.city }

    state
    country

    after(:build) do |address|
      address.addressable.addresses.reload if address.addressable.respond_to?(:addresses)
    end

    factory :invalid_address do
      address1 { nil }
    end
  end
end
