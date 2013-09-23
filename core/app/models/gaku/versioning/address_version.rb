module Gaku
  module Versioning
    class AddressVersion < PaperTrail::Version
      self.table_name = :gaku_versioning_address_versions

      scope :student_addresses, -> { where(item_type: 'Gaku::Address', join_model: 'Gaku::Student') }
    end
  end
end
