module Gaku
  class StudentSerializer < ActiveModel::Serializer
    belongs_to :enrollment_status

    attributes %i( id name surname middle_name name_reading middle_name_reading surname_reading
    gender birth_date admitted graduated code serial_id foreign_id_code national_registration_code
    enrollment_status_code picture_file_name picture_content_type picture_file_size
    picture_updated_at addresses_count contacts_count notes_count courses_count guardians_count
    external_school_records_count badges_count primary_address primary_contact class_and_number
    user_id faculty_id commute_method_type_id scholarship_status_id created_at updated_at
    extracurricular_activities_count class_groups_count exam_sessions_count)

  end
end
