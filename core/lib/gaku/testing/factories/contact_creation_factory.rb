FactoryBot.define do
  factory :contact_creation, class: Gaku::ContactCreation do
    data 'gaku@example.com'
    details 'My email'
    contact_type

    initialize_with { new(attributes) }

    after(:build) do |contact_creation|
      if contact_creation.contact.contactable.respond_to?(:contacts)
        contact_creation.contact.contactable.contacts.reload
      end
    end
  end
end
