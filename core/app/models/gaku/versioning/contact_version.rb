module Gaku::Versioning
  class ContactVersion < PaperTrail::Version

    self.table_name = :gaku_versioning_contact_versions

    scope :student_contacts, lambda { where(item_type: 'Gaku::Contact', join_model: 'Gaku::Student') }

  end
end
