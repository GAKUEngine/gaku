FactoryGirl.define do
  factory :country, :class => Gaku::Country do
    iso_name 'UNITED STATES'
    name 'United States of Foo'
    iso 'US'
    iso3 'USA'
    numcode 840
  end
end
