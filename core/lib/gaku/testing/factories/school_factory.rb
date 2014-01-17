FactoryGirl.define do

  factory :school, class: Gaku::School do
    name { Faker::Education.school_generic_name }
    slogan 'Draw the individual potencial'
    description 'Nagoya University description'
    founded Date.new(1950, 4, 1)
    principal 'Hajime Togari'

    factory :invalid_school do
      name nil
    end
  end

  factory :school_with_one_contact, parent: :school do
    after(:create) do |school|
      create(:contact, contactable: school.campuses.first)
    end
  end

  factory :school_with_two_contacts, parent: :school do
    after(:create) do |school|
      create(:contact, contactable: school.campuses.first)
      create(:contact, contactable: school.campuses.first)
    end
  end

  trait :master do
    primary true
  end

end
