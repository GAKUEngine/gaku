# == Schema Information
#
# Table name: contact_types
#
#  id   :integer          not null, primary key
#  name :string(255)
#

FactoryGirl.define do
  factory :contact_type do
    name "email"
  end
end
