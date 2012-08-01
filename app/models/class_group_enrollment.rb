# == Schema Information
#
# Table name: class_group_enrollments
#
#  id             :integer          not null, primary key
#  class_group_id :integer
#  student_id     :integer
#  seat_number    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class ClassGroupEnrollment < ActiveRecord::Base
  belongs_to :class_group
  belongs_to :student
  has_many :roles

  attr_accessible :seat_number, :roles, :class_group_id, :student_id
end
