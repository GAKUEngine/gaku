class PaperTrail::Version < ActiveRecord::Base
  scope :student_contacts, lambda { where(item_type: 'Gaku::Contact', join_model: 'Gaku::Student') }
  scope :student_addresses, lambda { where(item_type: 'Gaku::Address', join_model: 'Gaku::Student') }
end
