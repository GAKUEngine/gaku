class Contact < ActiveRecord::Base
  belongs_to :contact_type
  belongs_to :student
  
  attr_accessible :data, :details
end