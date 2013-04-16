FactoryGirl.define do
  factory :school, :class => Gaku::School do
    name "Nagoya City University"
    slogan "Draw the individual potencial"
    description "Nagoya University description"
    founded Date.new(1950, 4, 1)
    principal "Hajime Togari"
  end

  factory :school_with_one_contact, :parent => :school do
    after_create do |school|
      FactoryGirl.create(:contact, :contactable => school.campuses.first)
    end
  end

  factory :school_with_two_contacts, :parent => :school do
    after_create do |school|
      FactoryGirl.create(:contact, :contactable => school.campuses.first)
      FactoryGirl.create(:contact, :contactable => school.campuses.first)
    end
  end

  trait :master do
    is_primary true
  end

end
