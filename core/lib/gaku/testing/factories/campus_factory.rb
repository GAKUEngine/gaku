FactoryGirl.define do

  factory :campus, class: Gaku::Campus do
    name Faker::Education.school_generic_name
    #sequence(:name) { |n| "Takiko Campus_#{n}" }
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
