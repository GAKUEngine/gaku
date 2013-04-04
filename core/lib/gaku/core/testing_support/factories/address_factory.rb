FactoryGirl.define do

  factory :address, class: Gaku::Address do
    address1 { Faker::Address.street_address }
    address2 { Faker::Address.street_address }
    city     { Faker::Address.city }

    association(:state)

    country do |address|
      if address.state
        address.state.country
      else
        address.association(:country)
      end
    end
  end

end
