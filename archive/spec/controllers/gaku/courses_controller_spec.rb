require 'spec_helper_controllers'

describe Gaku::CoursesController do

  let(:course) { create(:course) }
  let(:deleted_course) { create(:course, deleted: true) }

  context 'as admin' do
    before { as :admin }

    context 'html' do

      describe 'PATCH #soft_delete' do
        let(:patch_soft_delete) { gaku_patch :soft_delete, id: course }

        it 'redirects' do
          patch_soft_delete
          should respond_with(302)
        end

        it 'assigns  @course' do
          patch_soft_delete
          expect(assigns(:course)).to eq course
        end

        it 'updates :deleted attribute' do
          expect do
            patch_soft_delete
            course.reload
          end.to change(course, :deleted)
        end
      end

    end

    context 'js' do

      describe 'JS PATCH #recovery' do
        let(:js_patch_recovery) { gaku_js_get :recovery, id: deleted_course }

        it 'is successfull' do
          js_patch_recovery
          should respond_with(200)
        end

        it 'assigns  @course' do
          js_patch_recovery
          expect(assigns(:course)).to eq deleted_course
        end

        it 'renders :recovery' do
          js_patch_recovery
          should render_template :recovery
        end

        it 'updates :deleted attribute' do
          expect do
            js_patch_recovery
            deleted_course.reload
          end.to change(deleted_course, :deleted)
        end
      end

      describe 'JS DELETE #destroy' do
        it 'deletes the course' do
          course
          expect do
            gaku_js_delete :destroy, id: course
          end.to change(Gaku::Course, :count).by(-1)
        end

        it 'decrements @count' do
          gaku_js_delete :destroy, id: course
          expect(assigns(:count)).to eq 0
        end

        it 'sets flash' do
          gaku_js_delete :destroy, id: course
          flash_destroyed?
        end
      end

    end
  end

end
