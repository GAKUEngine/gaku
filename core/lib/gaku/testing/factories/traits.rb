FactoryGirl.define do

  trait :with_note do
    after(:create) do |resource|
      create(:note, notable: resource)
      resource.notes.reload
    end
  end

  trait :with_notes do
    after(:create) do |resource|
      create_list :note, 2, notable: resource
      resource.notes.reload
    end
  end


  trait :with_address do
    after(:create) do |resource|
      create(:address, addressable: resource)
      resource.addresses.reload
    end
  end

  trait :with_addresses do
    after(:create) do |resource|
      create(:address, addressable: resource)
      create(:address, addressable: resource)
      resource.addresses.reload
    end
  end

  trait :with_contact do
    after(:create) do |resource|
      create(:contact, contactable: resource)
      resource.contacts.reload
    end
  end

  trait :with_contacts do
    after(:create) do |resource|
      create(:contact, contactable: resource)
      create(:contact, contactable: resource)
      resource.contacts.reload
    end
  end

  trait :with_student do
    after(:create) do |resource|
      resource.students << create(:student)
    end
  end

  trait :with_semesters do
    after(:create) do |resource|
      2.times do
        resource.semesters << create(:semester)
      end
    end
  end

  trait :with_semester do
    after(:create) do |resource|
      resource.semesters << create(:semester)
    end
  end

end
