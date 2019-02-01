require 'spec_helper_requests'

describe 'Students', type: :request do

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

  let(:student) { create(:student) }

  describe 'INDEX' do
    context 'JSON' do
      before do
        student
        api_get gaku.api_v1_students_path
      end

      it 'success response' do
        ensure_ok
      end

      it 'assign students' do
        expect(assigns['students']).to include(student)
      end

      it 'json attributes' do
        expect(json['students'].first).to include(*student_attributes)
      end

      it 'total_count' do
        expect(json['meta']).to include({total_count: 1})
      end
      it 'count' do
        expect(json['meta']).to include({count: 1})
      end
      it 'page' do
        expect(json['meta']).to include({page: 1})
      end
    end

    context 'MSGPACK' do
      before do
        student
        msgpack_api_get gaku.api_v1_students_path
      end

      it 'success response' do
        ensure_ok
      end

      it 'assign students' do
        expect(assigns['students']).to include(student)
      end

      it 'json attributes' do
        expect(msgpack['students'].first).to include(*student_attributes)
      end
      it 'total_count' do
        expect(msgpack['meta']).to include({total_count: 1})
      end
      it 'count' do
        expect(msgpack['meta']).to include({count: 1})
      end
      it 'page' do
        expect(msgpack['meta']).to include({page: 1})
      end
    end

  end

  describe 'SHOW' do
    context 'JSON' do
      describe 'success' do
        before do
          student
          api_get gaku.api_v1_student_path(student)
        end

        it 'success response' do
          ensure_ok
        end

        it 'assigns student' do
          expect(assigns['student']).to eq student
        end

        it 'json attributes' do
          expect(json).to include(*student_attributes)
        end
      end
      describe 'error' do
        before do
          api_get gaku.api_v1_student_path(id: 2000)
        end

        it 'render error' do
          expect(json).to eq({'error' => 'record not found'})
        end

        it 'response code' do
          ensure_not_found
        end
      end
    end

    context 'MSGPACK' do
      describe 'success' do
        before do
          student
          msgpack_api_get gaku.api_v1_student_path(student)
        end

        it 'success response' do
          ensure_ok
        end

        it 'assigns student' do
          expect(assigns['student']).to eq student
        end

        it 'json attributes' do
          expect(msgpack).to include(*student_attributes)
        end
      end

      describe 'error' do
        before do
          msgpack_api_get gaku.api_v1_student_path(id: 2000)
        end

        it 'render error' do
          expect(msgpack).to eq({'error' => 'record not found'})
        end

        it 'response code' do
          ensure_not_found
        end
      end
    end

    context 'picture' do
      describe 'success' do
        before do
          student
          msgpack_api_get gaku.picture_api_v1_student_path(student)
        end

        it 'success response' do
          ensure_ok
          expect(response.headers['Content-Disposition']).to eq("attachment; filename=\"#{student.picture_file_name}\"")
          expect(response.content_type).to eq('application/octet-stream')
        end
      end
    end
  end

  describe 'CREATE' do
    context 'JSON' do
      describe 'success' do
        before do
          expect do
            student_params = { student: { name: 'Mickey', surname: 'Mouse'} }
            api_post gaku.api_v1_students_path, params: student_params
          end.to change(Gaku::Student, :count).by(1)
        end

        it 'success response' do
          ensure_ok
        end

        it 'correct student attributes' do
          expect(json).to include(name: 'Mickey', surname: 'Mouse')
        end

        it 'json attributes' do
          expect(json).to include(*student_attributes)
        end
      end
      describe 'error' do

        before do
          api_post gaku.api_v1_students_path, params: {student: {name: 'Mickey'}}
        end

        it 'render error' do
          expect(json).to eq({'surname' => ["can't be blank"]})
        end

        it 'response code' do
          ensure_unprocessable_entity
        end
      end
    end
    context 'MSGPACK' do
      describe 'success' do
        before do
          expect do
            student_params = { student: { name: 'Mickey', surname: 'Mouse'} }
            msgpack_api_post gaku.api_v1_students_path, msgpack: student_params
          end.to change(Gaku::Student, :count).by(1)
        end

        it 'success response' do
          ensure_ok
        end

        it 'correct student attributes' do
          expect(msgpack).to include(name: 'Mickey', surname: 'Mouse')
        end

        it 'msgpack attributes' do
          expect(msgpack).to include(*student_attributes)
        end
      end
      describe 'error' do

        before do
          msgpack_api_post gaku.api_v1_students_path, msgpack: {student: {name: 'Mickey'}}
        end

        it 'render error' do
          expect(msgpack).to eq({'surname' => ["can't be blank"]})
        end

        it 'response code' do
          ensure_unprocessable_entity
        end
      end
    end


  end

  describe 'UPDATE' do
    context 'JSON' do
      describe 'success' do
        before do
          student = create(:student)
          student_params = { student: { name: 'Mini', surname: 'Mouse'} }
          api_patch gaku.api_v1_student_path(student), params: student_params
        end

        it 'success response' do
          ensure_ok
        end

        it 'correct student attributes' do
          expect(json).to include(name: 'Mini', surname: 'Mouse')
        end

        it 'json attributes' do
          expect(json).to include(*student_attributes)
        end
      end
      describe 'error' do

        before do
          student = create(:student)
          student_params = { student: { name: ''} }
          api_patch gaku.api_v1_student_path(student), params: student_params
        end

        it 'render error' do
          expect(json).to eq({'name' => ["can't be blank"]})
        end

        it 'response code' do
          ensure_unprocessable_entity
        end
      end
    end

    context 'MSGPACK' do
      describe 'success' do
        before do
          expect do
            student_params = { student: { name: 'Mini', surname: 'Mouse'} }
            msgpack_api_patch gaku.api_v1_student_path(student), msgpack: student_params
          end.to change(Gaku::Student, :count).by(1)
        end

        it 'success response' do
          ensure_ok
        end

        it 'correct student attributes' do
          expect(msgpack).to include(name: 'Mini', surname: 'Mouse')
        end

        it 'msgpack attributes' do
          expect(msgpack).to include(*student_attributes)
        end
      end
      describe 'error' do

        before do
          msgpack_api_patch gaku.api_v1_student_path(student), msgpack: {student: {name: ''}}
        end

        it 'render error' do
          expect(msgpack).to eq({'name' => ["can't be blank"]})
        end

        it 'response code' do
          ensure_unprocessable_entity
        end
      end
    end
  end

  describe 'DESTROY' do
    context 'JSON' do
      describe 'success' do
        before do
          student
          expect {
            api_delete gaku.api_v1_student_path(student)
          }.to change(Gaku::Student, :count).by(-1)
        end

        it 'success response' do
          ensure_ok
        end

        it 'assigns student' do
          expect(assigns['student']).to eq student
        end

        it 'json attributes' do
          expect(json).to include(*student_attributes)
        end
      end
      describe 'error' do
        before do
          api_delete gaku.api_v1_student_path(id: 2000)
        end

        it 'render error' do
          expect(json).to eq({'error' => 'record not found'})
        end

        it 'response code' do
          ensure_not_found
        end
      end
    end

    context 'MSGPACK' do
      describe 'success' do
        before do
          student
          msgpack_api_delete gaku.api_v1_student_path(student)
        end

        it 'success response' do
          ensure_ok
        end

        it 'assigns student' do
          expect(assigns['student']).to eq student
        end

        it 'json attributes' do
          expect(msgpack).to include(*student_attributes)
        end
      end

      describe 'error' do
        before do
          msgpack_api_delete gaku.api_v1_student_path(id: 2000)
        end

        it 'render error' do
          expect(msgpack).to eq({'error' => 'record not found'})
        end

        it 'response code' do
          ensure_not_found
        end
      end
    end

  end
end
