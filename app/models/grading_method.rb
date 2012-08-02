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

class GradingMethod < ActiveRecord::Base
	has_one :exam
  has_one :exam_portion
  has_one :assignment
  
  attr_accessible :description, :method, :name
end
