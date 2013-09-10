FactoryGirl.define do

  factory :contact_type, class: Gaku::ContactType do
    name 'Email'

    factory :invalid_contact_type do
      name nil
    end
  end

end
