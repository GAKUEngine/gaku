require 'spec_helper_requests'

describe 'Courses::Enrollments', type: :request do

  let(:enrollment_attributes) {
    %i( id student_id seat_number course_id )
  }

  let(:course) { create(:course) }
  let(:student) { create(:student) }
  let(:enrollment) { create(:course_enrollment) }
  let(:course_with_enrollment) { create(:course, :with_enrollment) }

  describe 'INDEX' do
    context 'JSON' do
      before do
        course_with_enrollment
        api_get gaku.api_v1_course_enrollments_path(course_with_enrollment)
      end

      it 'success response' do
        ensure_ok
      end

      it 'assign enrollments' do
        expect(assigns['enrollments']).to include(course_with_enrollment.enrollments.first)
      end

      it 'json attributes' do
        expect(json['enrollments'].first).to include(*enrollment_attributes)
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
        course_with_enrollment
        msgpack_api_get gaku.api_v1_course_enrollments_path(course_with_enrollment)
      end

      it 'success response' do
        ensure_ok
      end

      it 'assign enrollments' do
        expect(assigns['enrollments']).to include(course_with_enrollment.enrollments.first)
      end

      it 'json attributes' do
        expect(msgpack['enrollments'].first).to include(*enrollment_attributes)
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

  describe 'CREATE' do
    context 'JSON' do
      describe 'success' do
        before do
          course
          student
          expect do
            enrollment_params = { enrollment: { seat_number: 11111, student_id: student.id } }
            api_post gaku.api_v1_course_enrollments_path(course), params: enrollment_params
          end.to change(Gaku::Enrollment, :count).by(1)
        end

        it 'success response' do
          ensure_ok
        end

        it 'correct enrollment attributes' do
          expect(json).to include(seat_number: 11111)
        end

        it 'json attributes' do
          expect(json).to include(*enrollment_attributes)
        end
      end

      describe 'error' do
        before do
          course
          api_post gaku.api_v1_course_enrollments_path(course), params: { enrollment: { student_id: nil } }
        end

        it 'render error' do
          expect(json).to eq({ 'student_id' => ["can't be blank"] })
        end

        it 'response code' do
          ensure_unprocessable_entity
        end
      end
    end

    context 'MSGPACK' do
      describe 'success' do
        before do
          course
          student
          expect do
            enrollment_params = { enrollment: { seat_number: 11111, student_id: student.id } }
            msgpack_api_post gaku.api_v1_course_enrollments_path(course), msgpack: enrollment_params
          end.to change(Gaku::Enrollment, :count).by(1)
        end

        it 'success response' do
          ensure_ok
        end

        it 'correct enrollment attributes' do
          expect(msgpack).to include(seat_number: 11111)
        end

        it 'msgpack attributes' do
          expect(msgpack).to include(*enrollment_attributes)
        end
      end

      describe 'error' do
        before do
          course
          msgpack_api_post gaku.api_v1_course_enrollments_path(course), msgpack: { enrollment: { student: nil } }
        end

        it 'render error' do
          expect(msgpack).to eq({ 'student_id' => ["can't be blank"] })
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
          enrollment
          enrollment_params = { enrollment: { seat_number: 22222 } }
          api_patch gaku.api_v1_course_enrollment_path(enrollment.enrollable_id, enrollment), params: enrollment_params
        end

        it 'success response' do
          ensure_ok
        end

        it 'correct enrollment attributes' do
          expect(json).to include(seat_number: 22222)
        end

        it 'json attributes' do
          expect(json).to include(*enrollment_attributes)
        end
      end

      # describe 'error' do
      #   before do
      #     enrollment
      #     api_patch gaku.api_v1_course_enrollment_path(enrollment.enrollable_id, enrollment), params: { enrollment: { seat_number: nil } }
      #   end
      #
      #   it 'render error' do
      #     expect(json).to eq({ 'seat_number' => ["can't be blank"] })
      #   end
      #
      #   it 'response code' do
      #     ensure_unprocessable_entity
      #   end
      # end
    end

    context 'MSGPACK' do
      describe 'success' do
        before do
          enrollment
          enrollment_params = { enrollment: { seat_number: 22222 } }
          msgpack_api_patch gaku.api_v1_course_enrollment_path(enrollment.enrollable_id, enrollment), msgpack: enrollment_params
        end

        it 'success response' do
          ensure_ok
        end

        it 'correct enrollment attributes' do
          expect(msgpack).to include(seat_number: 22222)
        end

        it 'msgpack attributes' do
          expect(msgpack).to include(*enrollment_attributes)
        end
      end

    #   describe 'error' do
    #     before do
    #       enrollment
    #       msgpack_api_patch gaku.api_v1_course_erollment_path(enrollment.enrollable_id, enrollment), msgpack: { enrollment: { seat_number: '' } }
    #     end
    #
    #     it 'render error' do
    #       expect(msgpack).to eq( {'seat_number' => ["can't be blank"] })
    #     end
    #
    #     it 'response code' do
    #       ensure_unprocessable_entity
    #     end
    #   end
    end
  end
end
