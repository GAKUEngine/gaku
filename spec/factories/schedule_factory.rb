# == Schema Information
#
# Table name: schedules
#
#  id         :integer          not null, primary key
#  starting   :datetime
#  ending     :datetime
#  repeat     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :schedule do
    starting { Time.now }
    ending { starting + 40.minutes }
    repeat 3
  end
end
