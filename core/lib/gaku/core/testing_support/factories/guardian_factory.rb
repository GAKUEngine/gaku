FactoryGirl.define do
  factory :guardian, :class => Gaku::Guardian do
  	name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    relationship "Relationship"
  end

  factory :guardian_with_one_address, :parent => :guardian do
    after_create do |guardian|
      FactoryGirl.create(:address, :addressable => guardian)
    end
  end

  factory :guardian_with_two_addresses, :parent => :guardian do
    after_create do |guardian|
      FactoryGirl.create(:address, :addressable => guardian)
      FactoryGirl.create(:address, :addressable => guardian)
    end
  end

  factory :guardian_with_one_contact, :parent => :guardian do
    after_create do |guardian|
      FactoryGirl.create(:contact, :contactable => guardian)
    end
  end

  factory :guardian_with_two_contacts, :parent => :guardian do
    after_create do |guardian|
      FactoryGirl.create(:contact, :contactable => guardian)
      FactoryGirl.create(:contact, :contactable => guardian)
    end
  end

end
