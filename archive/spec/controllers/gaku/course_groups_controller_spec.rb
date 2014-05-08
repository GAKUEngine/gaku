require 'spec_helper_controllers'

describe Gaku::CourseGroupsController do

  let(:course_group) { create(:course_group) }
  let(:deleted_course_group) { create(:course_group, deleted: true) }

  context 'as admin' do
    before { as :admin }

    context 'html' do

      describe 'PATCH #soft_delete' do
        let(:patch_soft_delete) { gaku_patch :soft_delete, id: course_group }

        it 'redirects' do
          patch_soft_delete
          should respond_with(302)
        end

        it 'assigns  @course_group' do
          patch_soft_delete
          expect(assigns(:course_group)).to eq course_group
        end

        it 'updates :deleted attribute' do
          expect do
            patch_soft_delete
            course_group.reload
          end.to change(course_group, :deleted)
        end
      end

    end

    context 'js' do

      describe 'JS DELETE #destroy' do
        it 'deletes the course_group' do
          course_group
          expect do
            gaku_js_delete :destroy, id: course_group
          end.to change(Gaku::CourseGroup, :count).by(-1)
        end

        it 'decrements @count' do
          gaku_js_delete :destroy, id: course_group
          expect(assigns(:count)).to eq 0
        end

        it 'sets flash' do
          gaku_js_delete :destroy, id: course_group
          flash_destroyed?
        end
      end

      describe 'JS PATCH #recovery' do
        let(:js_patch_recovery) { gaku_js_patch :recovery, id: deleted_course_group }

        it 'is successfull' do
          js_patch_recovery
          should respond_with(200)
        end

        it 'assigns  @course_group' do
          js_patch_recovery
          expect(assigns(:course_group)).to eq deleted_course_group
        end

        it 'renders :recovery' do
          js_patch_recovery
          should render_template :recovery
        end

        it 'updates :deleted attribute' do
          expect do
            js_patch_recovery
            deleted_course_group.reload
          end.to change(deleted_course_group, :deleted)
        end
      end

    end
  end

end
