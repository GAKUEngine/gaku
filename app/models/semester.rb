class Semester < ActiveRecord::Base
  belongs_to :class_group
  
  attr_accessible :starting, :ending, :class_group_id 
end

# == Schema Information
#
# Table name: semesters
#
#  id             :integer         not null, primary key
#  starting       :date
#  ending         :date
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#  class_group_id :integer
#

