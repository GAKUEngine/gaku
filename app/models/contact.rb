# == Schema Information
#
# Table name: contacts
#
#  id              :integer          not null, primary key
#  data            :string(255)
#  details         :text
#  is_primary      :boolean          default(FALSE)
#  is_emergency    :boolean          default(FALSE)
#  contact_type_id :integer
#  student_id      :integer
#  guardian_id     :integer
#  faculty_id      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Contact < ActiveRecord::Base
  belongs_to :contact_type
  belongs_to :student
  belongs_to :guardian
  
  attr_accessible :data, :details, :contact_type_id, :is_primary, :is_emergency

  validates_presence_of :data,:contact_type_id

  before_save :ensure_first_primary, :on => :create


  def make_primary_student
    self.update_attributes(:is_primary => true)
    user_contacts = Contact.where(:student_id => self.student_id)
    user_contacts.update_all('is_primary = 0', "id <> #{self.id}")
   end

   def make_primary_guardian
    self.update_attributes(:is_primary => true)
    user_contacts = Contact.where(:guardian_id => self.guardian_id)
    user_contacts.update_all('is_primary = 0', "id <> #{self.id}")
   end


  private

  def ensure_first_primary
  	if self.student_id
  		user_contacts = Contact.where(:student_id => self.student_id)
			user_contacts.blank? && (self.is_primary == false) ? self.is_primary=true : nil    	
  	elsif self.guardian_id
      user_contacts = Contact.where(:guardian_id => self.guardian_id)
      user_contacts.blank? && (self.is_primary == false) ? self.is_primary=true : nil 
    end
  end  
end

