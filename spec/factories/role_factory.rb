# == Schema Information
#
# Table name: roles
#
#  id                        :integer          not null, primary key
#  name                      :string(255)
#  class_group_enrollment_id :integer
#  faculty_id                :integer
#

FactoryGirl.define do
  factory :role do
    name "Role #1"
  end

  factory :admin_role, :parent => :role do
    name 'admin'
  end
end
