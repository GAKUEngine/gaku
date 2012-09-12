# == Schema Information
#
# Table name: lessons
#
#  id             :integer          not null, primary key
#  lesson_plan_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Lesson < ActiveRecord::Base
  belongs_to :lesson_plan
  has_many :attendances, :as => :attendancable
  
end
