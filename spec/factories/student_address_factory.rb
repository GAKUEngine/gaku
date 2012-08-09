# == Schema Information
#
# Table name: student_addresses
#
#  id         :integer          not null, primary key
#  student_id :integer
#  address_id :integer
#  is_primary :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :student_address do
    association(:address)
    association(:student)
  end
end
