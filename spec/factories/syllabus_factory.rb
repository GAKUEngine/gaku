# == Schema Information
#
# Table name: syllabuses
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  code        :string(255)
#  description :text
#  credits     :integer
#  hours       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :syllabus do
    name { Faker::Name.name }
    code "12345"
    description "Short description"
    credits "Huge Credits"
  end
end
