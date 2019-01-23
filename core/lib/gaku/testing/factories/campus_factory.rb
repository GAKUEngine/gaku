FactoryBot.define do

  factory :campus, class: Gaku::Campus do
    name { FFaker::Education.school_generic_name }
    school

    factory :invalid_campus do
      name nil
    end
  end

  trait :with_one_address do
    after(:create) do |campus|
      campus.address = create(:address, addressable: campus)
      campus.save
    end
  end

end
