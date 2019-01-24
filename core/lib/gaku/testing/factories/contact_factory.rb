FactoryBot.define do
  factory :contact, class: Gaku::Contact do
    data 'gaku@example.com'
    details 'My email'
    contact_type

    after(:build) do |contact|
      contact.contactable.contacts.reload if contact.contactable.respond_to?(:contacts)
    end

    factory :invalid_contact do
      data nil
    end
  end
end
