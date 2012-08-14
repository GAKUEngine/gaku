# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  address1   :string(255)
#  address2   :string(255)
#  city       :string(255)
#  zipcode    :string(255)
#  state      :string(255)
#  state_name :string(255)
#  title      :string(255)
#  past       :boolean          default(FALSE)
#  country_id :integer
#  state_id   :integer
#  faculty_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :address do
    address1 '10 Lovely Street'
    address2 'Northwest'
    city   'Herndon'
    zipcode '20170'

    state  { |address| address.association(:state) }
    country do |address|
      if address.state
        address.state.country
      else
        address.association(:country)
      end
    end
  end
end
