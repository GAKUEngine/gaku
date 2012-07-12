class Contact < ActiveRecord::Base
  belongs_to :contact_type
  belongs_to :student
  
  attr_accessible :data, :details
end
# == Schema Information
#
# Table name: contacts
#
#  id              :integer         not null, primary key
#  data            :string(255)
#  details         :text
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  contact_type_id :integer
#  student_id      :integer
#  guardian_id     :integer
#  faculty_id      :integer
#

