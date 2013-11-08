require 'spec_helper'

describe Gaku::Students::CourseEnrollmentsController do

  let(:student) { create(:student) }
  let!(:course) { create(:course) }
  let(:course_enrollment) { create(:course_enrollment, course: course, student: student)}

  context 'as admin' do
    before { as :admin }

    context 'JS' do

      describe 'JS GET #new' do
        before { gaku_js_get :new, student_id: student.id }

        it { should respond_with 200 }
        it('assigns @course_enrollment') { expect(assigns(:course_enrollment)).to be_a_new(Gaku::CourseEnrollment) }
        it('assigns @courses') { expect(assigns(:courses)).to_not be_empty }
        it('renders the :new template') { template? :new }
      end

      describe 'JS POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create, course_enrollment: attributes_for(:course_enrollment, course_id: course.id, student_id: student.id), student_id: student.id
          end

          it 'creates new course_enrollment' do
            expect do
              expect do
                valid_js_create
              end.to change(Gaku::CourseEnrollment, :count).by(1)
            end.to change(student.course_enrollments, :count).by(1)
          end

          it 'renders flash' do
            valid_js_create
            flash_created?
          end

          it 'increments @count' do
            valid_js_create
            expect(assigns(:count)).to eq 1
          end
        end

        context 'with invalid attributes' do
          let(:invalid_js_create) do
            gaku_js_post :create, course_enrollment: attributes_for(:invalid_course_enrollment, course_id: nil, student_id: student.id), student_id: student.id
          end

          it 'does not save the new course_enrollment' do
            expect do
              invalid_js_create
            end.to_not change(Gaku::CourseEnrollment, :count)
          end

          it 'renders :error template' do
            invalid_js_create
            template? :error
          end

          it "doesn't increment @count" do
            invalid_js_create
            expect(assigns(:count)).to eq 0
          end
        end

        context 'duplicate course_enrollment' do
          let(:invalid_js_create) do
            gaku_js_post :create, course_enrollment: attributes_for(:invalid_course_enrollment, course_id: nil, student_id: student.id), student_id: student.id
          end

          before { create(:course_enrollment, course: course, student: student) }

          it 'does not save the new course_enrollment' do
            expect do
              invalid_js_create
            end.to_not change(Gaku::CourseEnrollment, :count)
          end

          it 'renders :error template' do
            invalid_js_create
            template? :error
          end

          it "doesn't increment @count" do
            invalid_js_create
            expect(assigns(:count)).to eq 1
          end
        end

      end

      describe 'JS DELETE #destroy' do

        let(:js_delete) { gaku_js_delete :destroy, id: course_enrollment, student_id: student.id }

        it 'deletes the course_enrollment' do
          course_enrollment
          expect do
            js_delete
          end.to change(Gaku::CourseEnrollment, :count).by(-1)
        end

        it 'decrements @count' do
          js_delete
          expect(assigns(:count)).to eq 0
        end

        it 'sets flash' do
          js_delete
          flash_destroyed?
        end
      end

    end
  end

end
