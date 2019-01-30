FactoryBot.define do
  factory :country, class: Gaku::Country do
    iso_name { 'UNITED STATES' }
    name { 'United States of Foo' }
    sequence(:iso) { |n| "US_#{n}" }
    sequence(:iso3) { |n| "USA_#{n}" }
    numcode { 840 }
  end
end
