# == Schema Information
#
# Table name: faculties
#
#  id      :integer          not null, primary key
#  user_id :integer
#

class Faculty < ActiveRecord::Base
  has_many :roles 
  has_many :students
  has_many :class_groups
  has_many :courses
  has_many :addresses
  has_many :contacts
end
