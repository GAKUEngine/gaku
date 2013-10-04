FactoryGirl.define do

  factory :address, class: Gaku::Address do
    address1 { Faker::Address.street_address }
    address2 { Faker::Address.street_address }
    city     { Faker::Address.city }

    state
    country

    factory :invalid_address  do
      address1 nil
    end
  end

end
