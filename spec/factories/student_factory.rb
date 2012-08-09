# == Schema Information
#
# Table name: students
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  surname              :string(255)
#  name_reading         :string(255)      default("")
#  surname_reading      :string(255)      default("")
#  gender               :boolean
#  phone                :string(255)
#  email                :string(255)
#  birth_date           :date
#  admitted             :date
#  graduated            :date
#  user_id              :integer
#  faculty_id           :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

FactoryGirl.define do
  factory :student do
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    name_reading { Faker::Name.first_name }
    surname_reading { Faker::Name.last_name }
    phone { Faker::PhoneNumber::phone_number }
    email { Faker::Internet::email }
    gender "male"
  end
end
