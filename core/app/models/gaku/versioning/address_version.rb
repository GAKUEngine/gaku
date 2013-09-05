module Gaku
  module Versioning
    class AddressVersion < PaperTrail::Version

      self.table_name = :gaku_versioning_address_versions

      scope :student_addresses, lambda { where(item_type: 'Gaku::Address', join_model: 'Gaku::Student') }

    end
  end
end
