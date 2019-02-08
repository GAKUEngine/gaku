require 'spec_helper_requests'

describe 'Courses::Students', type: :request do

  let(:student_attributes) {
    %i( id name surname middle_name name_reading middle_name_reading surname_reading
      gender birth_date admitted graduated code serial_id foreign_id_code national_registration_code
      enrollment_status_code picture_file_name picture_content_type picture_file_size
      picture_updated_at addresses_count contacts_count notes_count courses_count guardians_count
      external_school_records_count badges_count primary_address primary_contact class_and_number
      user_id faculty_id commute_method_type_id scholarship_status_id created_at updated_at
      extracurricular_activities_count class_groups_count exam_sessions_count
    )
  }

  let(:course_with_student) { create(:course, :with_student) }

  describe 'INDEX' do
    context 'JSON' do
      before do
        course_with_student
        api_get gaku.api_v1_course_students_path(course_with_student)
      end

      it 'success response' do
        ensure_ok
      end

      it 'assign students' do
        expect(assigns['students']).to include(course_with_student.students.first)
      end

      it 'json attributes' do
        expect(json['students'].first).to include(*student_attributes)
      end

      it 'total_count' do
        expect(json['meta']).to include({ total_count: 1 })
      end
      it 'count' do
        expect(json['meta']).to include({ count: 1 })
      end
      it 'page' do
        expect(json['meta']).to include({ page: 1 })
      end
    end

    context 'MSGPACK' do
      before do
        course_with_student
        msgpack_api_get gaku.api_v1_course_students_path(course_with_student)
      end

      it 'success response' do
        ensure_ok
      end

      it 'assign students' do
        expect(assigns['students']).to include(course_with_student.students.first)
      end

      it 'json attributes' do
        expect(msgpack['students'].first).to include(*student_attributes)
      end
      it 'total_count' do
        expect(msgpack['meta']).to include({ total_count: 1 })
      end
      it 'count' do
        expect(msgpack['meta']).to include({ count: 1 })
      end
      it 'page' do
        expect(msgpack['meta']).to include({ page: 1 })
      end
    end
  end
end
