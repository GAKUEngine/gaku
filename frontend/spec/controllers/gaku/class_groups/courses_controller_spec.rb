require 'spec_helper_controllers'

describe Gaku::ClassGroups::CoursesController do

  let(:class_group) { create(:class_group) }
  let(:course) { create(:course) }
  let(:class_group_course_enrollment) { create(:class_group_course_enrollment, class_group: class_group, course: course)}

  context 'as admin' do
    before { as :admin }

    context 'js' do

      describe 'JS #new' do
        before { gaku_js_get :new, class_group_id: class_group }

        it { should respond_with 200 }
        it('assigns @class_group_course_enrollment') { expect(assigns(:class_group_course_enrollment)).to be_a_new(Gaku::ClassGroupCourseEnrollment) }
        it('renders the :new template') { template? :new }
      end

      describe 'JS POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create, class_group_id: class_group, class_group_course_enrollment: attributes_for(:class_group_course_enrollment, course_id: course.id, class_group_id: class_group.id)
          end

          it 'creates new class_group' do
            expect do
              valid_js_create
            end.to change(Gaku::ClassGroupCourseEnrollment, :count).by(1)
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
            gaku_js_post :create, class_group_id: class_group, class_group_course_enrollment: attributes_for(:class_group, course_id: nil)
          end

          it 'does not save the new class_group' do
            expect do
              invalid_js_create
            end.to_not change(Gaku::ClassGroupCourseEnrollment, :count)
          end

          it 're-renders the new method' do
            invalid_js_create
            template? :create
          end

          it "doesn't increment @count" do
            invalid_js_create
            expect(assigns(:count)).to eq 0
          end
        end
      end

      describe 'JS DELETE #destroy' do
        it 'deletes the class_group' do
          class_group_course_enrollment
          expect do
            gaku_js_delete :destroy, class_group_id: class_group, id: class_group_course_enrollment
          end.to change(Gaku::ClassGroupCourseEnrollment, :count).by(-1)
        end

        it 'decrements @count' do
          gaku_js_delete :destroy, class_group_id: class_group, id: class_group_course_enrollment
          expect(assigns(:count)).to eq 0
        end

        it 'sets flash' do
          gaku_js_delete :destroy, class_group_id: class_group, id: class_group_course_enrollment
          flash_destroyed?
        end
      end

    end
  end

end
