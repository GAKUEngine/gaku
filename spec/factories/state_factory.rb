# == Schema Information
#
# Table name: states
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  abbr            :string(255)
#  name_ascii      :string(255)
#  country_numcode :integer
#

FactoryGirl.define do
  factory :state do
    name 'Alabama'
    abbr 'AL'
    country do |country|
      if usa = Country.find_by_numcode(840)
        country = usa
      else
        country.association(:country)
      end
    end
  end
end
