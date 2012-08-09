# == Schema Information
#
# Table name: class_groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  grade      :integer
#  homeroom   :string(255)
#  faculty_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :class_group do
    name "1A"
    grade 8
    homeroom "123"
  end
end
