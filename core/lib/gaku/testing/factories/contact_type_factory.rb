FactoryBot.define do

  factory :contact_type, class: Gaku::ContactType do
    sequence(:name) { |n| "Email_#{n}" }

    factory :invalid_contact_type do
      name nil
    end
  end

end
