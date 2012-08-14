# == Schema Information
#
# Table name: grading_methods
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  method      :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :grading_method do
    name "Method 1"
    method "Method"
    description "Grading method description"
  end
end
