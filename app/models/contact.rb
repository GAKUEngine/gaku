class Contact < ActiveRecord::Base
  belongs_to :contact_type
  belongs_to :student
  belongs_to :guardian
  
  attr_accessible :data, :details, :contact_type_id, :is_primary, :is_emergency

  validates_presence_of :data, :details, :contact_type_id
end

# == Schema Information
#
# Table name: contacts
#
#  id              :integer         not null, primary key
#  data            :string(255)
#  details         :text
#  is_primary      :boolean
#  is_emergency    :boolean
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  contact_type_id :integer
#  student_id      :integer
#  guardian_id     :integer
#  faculty_id      :integer
#

