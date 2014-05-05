require 'spec_helper_controllers'

describe Gaku::CourseGroups::CourseGroupEnrollmentsController do

  let(:course_group) { create(:course_group) }
  let(:course) { create(:course) }
  let(:course_group_enrollment) { create(:course_group_enrollment, course_group: course_group, course: course) }

  context 'as admin' do
    before { as :admin }

    context 'js' do

      describe 'JS #new' do
        before { gaku_js_get :new, course_group_id: course_group }

        it { should respond_with 200 }

        it('assigns @course_group_enrollment') do
          expect(assigns(:course_group_enrollment)).to be_a_new(Gaku::CourseGroupEnrollment)
        end

        it('renders the :new template') { template? :new }
      end

      describe 'JS POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create, course_group_id: course_group,
                                  course_group_enrollment: attributes_for(:course_group_enrollment,
                                                                          course_id: course.id,
                                                                          course_group_id: course_group.id)
          end

          it 'creates new course_group' do
            expect do
              valid_js_create
            end.to change(Gaku::CourseGroupEnrollment, :count).by(1)
          end

          xit 'renders flash' do
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
            gaku_js_post :create, course_group_id: course_group,
                                  course_group_enrollment: attributes_for(:course_group, course_id: nil)
          end

          xit 'does not save the new course_group' do
            expect do
              invalid_js_create
            end.to_not change(Gaku::CourseGroupEnrollment, :count)
          end

          xit 're-renders the new method' do
            invalid_js_create
            template? :create
          end

          xit "doesn't increment @count" do
            invalid_js_create
            expect(assigns(:count)).to eq 0
          end
        end
      end

      describe 'JS DELETE #destroy' do
        it 'deletes the course_group' do
          course_group_enrollment
          expect do
            gaku_js_delete :destroy, course_group_id: course_group, id: course_group_enrollment
          end.to change(Gaku::CourseGroupEnrollment, :count).by(-1)
        end

        it 'decrements @count' do
          gaku_js_delete :destroy, course_group_id: course_group, id: course_group_enrollment
          expect(assigns(:count)).to eq 0
        end

        it 'sets flash' do
          gaku_js_delete :destroy, course_group_id: course_group, id: course_group_enrollment
          flash_destroyed?
        end
      end

    end
  end

end
