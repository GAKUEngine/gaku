class ContactType < ActiveRecord::Base
  has_many :contacts
  
  attr_accessible :name
end
# == Schema Information
#
# Table name: contact_types
#
#  id   :integer         not null, primary key
#  name :string(255)
#

