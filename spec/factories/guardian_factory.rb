# == Schema Information
#
# Table name: guardians
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  surname         :string(255)
#  name_reading    :string(255)
#  surname_reading :string(255)
#  relationship    :string(255)
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :guardian do
  	name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    relationship "Relationship" 
  end
end
