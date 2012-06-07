class Contact < ActiveRecord::Base
  belongs_to :contact_type
  belongs_to :student
  
  attr_accessible :data, :contact_type_id, :details
end