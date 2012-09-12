# == Schema Information
#
# Table name: assets
#
#  id              :integer          not null, primary key
#  exam_portion_id :integer
#  lesson_plan_id  :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Asset < ActiveRecord::Base
	belongs_to :exam_portion
	belongs_to :lesson_plan
end
