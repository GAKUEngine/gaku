# == Schema Information
#
# Table name: countries
#
#  id       :integer          not null, primary key
#  iso_name :string(255)
#  iso      :string(255)
#  iso3     :string(255)
#  name     :string(255)
#  numcode  :integer
#

FactoryGirl.define do
  factory :country do
    iso_name 'UNITED STATES'
    name 'United States of Foo'
    iso 'US'
    iso3 'USA'
    numcode 840
  end
end
