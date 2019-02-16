require 'spec_helper_requests'

describe 'Courses', type: :request do

  let(:course_attributes) {
    %i( id name code notes_count faculty_id
      syllabus_id class_group_id enrollments_count
    )
  }

  let(:course) { create(:course) }

  describe 'INDEX' do
    context 'JSON' do
      before do
        course
        api_get gaku.api_v1_courses_path
      end

      it 'success response' do
        ensure_ok
      end

      it 'assign courses' do
        expect(assigns['courses']).to include(course)
      end

      it 'json attributes' do
        expect(json['courses'].first).to include(*course_attributes)
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
        course
        msgpack_api_get gaku.api_v1_courses_path
      end

      it 'success response' do
        ensure_ok
      end

      it 'assign courses' do
        expect(assigns['courses']).to include(course)
      end

      it 'json attributes' do
        expect(msgpack['courses'].first).to include(*course_attributes)
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
          course
          api_get gaku.api_v1_course_path(course)
        end

        it 'success response' do
          ensure_ok
        end

        it 'assigns course' do
          expect(assigns['course']).to eq course
        end

        it 'json attributes' do
          expect(json).to include(*course_attributes)
        end
      end
      describe 'error' do
        before do
          api_get gaku.api_v1_course_path(id: 2000)
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
          course
          msgpack_api_get gaku.api_v1_course_path(course)
        end

        it 'success response' do
          ensure_ok
        end

        it 'assigns course' do
          expect(assigns['course']).to eq course
        end

        it 'json attributes' do
          expect(msgpack).to include(*course_attributes)
        end
      end

      describe 'error' do
        before do
          msgpack_api_get gaku.api_v1_course_path(id: 2000)
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

  describe 'CREATE' do
    context 'JSON' do
      describe 'success' do
        before do
          expect do
            course_params = { code: 'Mickey Course'}
            api_post gaku.api_v1_courses_path, params: course_params
          end.to change(Gaku::Course, :count).by(1)
        end

        it 'success response' do
          ensure_ok
        end

        it 'correct course attributes' do
          expect(json).to include(code: 'Mickey Course')
        end

        it 'json attributes' do
          expect(json).to include(*course_attributes)
        end
      end
      describe 'error' do

        before do
          api_post gaku.api_v1_courses_path, params: { code: '' }
        end

        it 'render error' do
          expect(json).to eq({'error' => "param is missing or the value is empty: code"})
        end

        it 'response code' do
          ensure_internal_server_error
        end
      end
    end
    context 'MSGPACK' do
      describe 'success' do
        before do
          expect do
            course_params = { code: 'Mickey Course' }
            msgpack_api_post gaku.api_v1_courses_path, msgpack: course_params
          end.to change(Gaku::Course, :count).by(1)
        end

        it 'success response' do
          ensure_ok
        end

        it 'correct course attributes' do
          expect(msgpack).to include(code: 'Mickey Course')
        end

        it 'msgpack attributes' do
          expect(msgpack).to include(*course_attributes)
        end
      end
      describe 'error' do

        before do
          msgpack_api_post gaku.api_v1_courses_path, msgpack: {code: ''}
        end

        it 'render error' do
          expect(msgpack).to eq({'error' => "param is missing or the value is empty: code"})
        end

        it 'response code' do
          ensure_internal_server_error
        end
      end
    end
  end

  describe 'UPDATE' do
    context 'JSON' do
      describe 'success' do
        before do
          course = create(:course)
          course_params = {code: 'Mini Course'}
          api_patch gaku.api_v1_course_path(course), params: course_params
        end

        it 'success response' do
          ensure_ok
        end

        it 'correct course attributes' do
          expect(json).to include(code: 'Mini Course')
        end

        it 'json attributes' do
          expect(json).to include(*course_attributes)
        end
      end
      describe 'error' do

        before do
          course = create(:course)
          course_params = { code: ''}
          api_patch gaku.api_v1_course_path(course), params: course_params
        end

        it 'render error' do
          expect(json).to eq({'error' => "param is missing or the value is empty: code"})
        end

        it 'response code' do
          ensure_internal_server_error
        end
      end
    end

    context 'MSGPACK' do
      describe 'success' do
        before do
          expect do
            course_params = {code: 'Mini Course' }
            msgpack_api_patch gaku.api_v1_course_path(course), msgpack: course_params
          end.to change(Gaku::Course, :count).by(1)
        end

        it 'success response' do
          ensure_ok
        end

        it 'correct course attributes' do
          expect(msgpack).to include(code: 'Mini Course')
        end

        it 'msgpack attributes' do
          expect(msgpack).to include(*course_attributes)
        end
      end
      describe 'error' do

        before do
          msgpack_api_patch gaku.api_v1_course_path(course), msgpack: {code: ''}
        end

        it 'render error' do
          expect(msgpack).to eq({'error' => "param is missing or the value is empty: code"})
        end

        it 'response code' do
          ensure_internal_server_error
        end
      end
    end
  end

  describe 'DESTROY' do
    context 'JSON' do
      describe 'success' do
        before do
          course
          expect {
            api_delete gaku.api_v1_course_path(course)
          }.to change(Gaku::Course, :count).by(-1)
        end

        it 'success response' do
          ensure_ok
        end

        it 'assigns course' do
          expect(assigns['course']).to eq course
        end

        it 'json attributes' do
          expect(json).to include(*course_attributes)
        end
      end
      describe 'error' do
        before do
          api_delete gaku.api_v1_course_path(id: 2000)
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
          course
          msgpack_api_delete gaku.api_v1_course_path(course)
        end

        it 'success response' do
          ensure_ok
        end

        it 'assigns course' do
          expect(assigns['course']).to eq course
        end

        it 'json attributes' do
          expect(msgpack).to include(*course_attributes)
        end
      end

      describe 'error' do
        before do
          msgpack_api_delete gaku.api_v1_course_path(id: 2000)
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
