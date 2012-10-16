# == Schema Information
#
# Table name: notes
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  content        :text
#  student_id     :integer
#  lesson_plan_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Note < ActiveRecord::Base
  belongs_to :notable, polymorphic: true
  
  attr_accessible :title, :content
end
