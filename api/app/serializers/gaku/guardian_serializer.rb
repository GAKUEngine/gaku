module Gaku
  class GuardianSerializer < ActiveModel::Serializer
    attributes %i( id name surname middle_name name_reading middle_name_reading surname_reading
      gender birth_date relationship picture_file_name picture_content_type picture_file_size
      picture_updated_at primary_address primary_contact addresses_count contacts_count user_id
      created_at updated_at
    )
  end
end
