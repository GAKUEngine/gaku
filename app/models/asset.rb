class Asset < ActiveRecord::Base
	belongs_to :exam_portion
	belongs_to :lesson_plan
end