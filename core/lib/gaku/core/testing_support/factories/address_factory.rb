FactoryGirl.define do
  factory :address do
    address1 '10 Lovely Street'
    address2 'Northwest'
    city   'Herndon'
    zipcode '20170'

    state  { |address| address.association(:state) }
    country do |address|
      if address.state
        address.state.country
      else
        address.association(:country)
      end
    end
  end
end
