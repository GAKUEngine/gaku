class Guardian < ActiveRecord::Base
  belongs_to :user
  belongs_to :profile
  has_and_belongs_to_many :addresses
  has_and_belongs_to_many :students
  has_many :contact_types

  attr_accessible :student_id, :relationship, :contact_types, :contact_types_attributes
  accepts_nested_attributes_for :contact_types, :allow_destroy => true
end
# == Schema Information
#
# Table name: guardians
#
#  id           :integer         not null, primary key
#  relationship :string(255)
#  profile_id   :integer
#  user_id      :integer
#

