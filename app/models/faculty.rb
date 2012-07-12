class Faculty < ActiveRecord::Base
  has_many :roles 
  has_many :students
  has_many :class_groups
  has_many :courses
  belongs_to :profile
  has_many :addresses
  has_many :contacts
end
# == Schema Information
#
# Table name: faculties
#
#  id         :integer         not null, primary key
#  profile_id :integer
#  users_id   :integer
#

