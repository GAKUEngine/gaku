# == Schema Information
#
# Table name: guardian_addresses
#
#  id          :integer          not null, primary key
#  guardian_id :integer
#  address_id  :integer
#  is_primary  :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :guardian_address do
    association(:address)
    association(:guardian)
  end
end
