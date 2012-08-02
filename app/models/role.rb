# == Schema Information
#
# Table name: roles
#
#  id                        :integer          not null, primary key
#  name                      :string(255)
#  class_group_enrollment_id :integer
#  faculty_id                :integer
#

class Role < ActiveRecord::Base
  belongs_to :class_group_enrollment
  belongs_to :faculty
  
  attr_accessible :name, :class_group_enrollment_id
end
