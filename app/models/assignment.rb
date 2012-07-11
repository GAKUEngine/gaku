class Assignment < ActiveRecord::Base
	belongs_to :syllabus

	attr_accessible :name, :description, :max_score, :syllabus_id
end
# == Schema Information
#
# Table name: assignments
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  max_score   :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  syllabus_id :integer
#

