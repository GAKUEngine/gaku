FactoryBot.define do

  factory :guardian, class: Gaku::Guardian do
    name { FFaker::Name.first_name }
    surname { FFaker::Name.last_name }
    relationship 'Relationship'

    factory(:invalid_guardian) { name nil }
  end

end
