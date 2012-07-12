class Note < ActiveRecord::Base
  belongs_to :student
  
  attr_accessible :title, :content
end
# == Schema Information
#
# Table name: notes
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  content    :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  student_id :integer
#

