class Version < ActiveRecord::Base
  attr_accessible :join_model, :joined_resource_id

  scope :students, lambda { where(:item_type => 'Gaku::Student') }
  scope :student_contacts, lambda { where(:item_type => 'Gaku::Contact', :join_model => 'Gaku::Student') }
  scope :student_addresses, lambda { where(:item_type => 'Gaku::Address', :join_model => 'Gaku::Student') }
end
