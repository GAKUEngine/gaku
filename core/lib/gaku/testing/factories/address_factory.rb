FactoryGirl.define do

  factory :address, class: Gaku::Address do
    address1 { Faker::Address.street_address }
    address2 { Faker::Address.street_address }
    city     { Faker::Address.city }

    state
    country

    after(:build) do |address|
      if address.addressable.respond_to?(:addresses)
        address.addressable.addresses.reload
      end
    end

    factory :invalid_address  do
      address1 nil
    end
  end

end
