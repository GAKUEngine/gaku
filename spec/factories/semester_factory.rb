# == Schema Information
#
# Table name: semesters
#
#  id             :integer          not null, primary key
#  starting       :date
#  ending         :date
#  class_group_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryGirl.define do
  factory :semester do
    starting { Time.now }
    ending { starting + 6.months }
  end
end
