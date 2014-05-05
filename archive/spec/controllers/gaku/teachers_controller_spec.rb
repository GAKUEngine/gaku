require 'spec_helper_controllers'

describe Gaku::TeachersController do

  let(:teacher) { create(:teacher) }
  let(:deleted_teacher) { create(:teacher, deleted: true) }

  context 'as admin' do
    before { as :admin }

    context 'html' do

      describe 'PATCH #soft_delete' do
        let(:patch_soft_delete) { gaku_patch :soft_delete, id: teacher }

        it 'redirects' do
          patch_soft_delete
          should respond_with(302)
        end

        it 'assigns  @teacher' do
          patch_soft_delete
          expect(assigns(:teacher)).to eq teacher
        end

        it 'updates :deleted attribute' do
          expect do
            patch_soft_delete
            teacher.reload
          end.to change(teacher, :deleted)
        end
      end

    end

    context 'js' do

      describe 'XHR DELETE #destroy' do
        it 'deletes the teacher' do
          teacher
          expect do
            gaku_js_delete :destroy, id: teacher
          end.to change(Gaku::Teacher, :count).by(-1)
        end

        it 'decrements @count' do
          gaku_js_delete :destroy, id: teacher
          expect(assigns(:count)).to eq 0
        end

        it 'sets flash' do
          gaku_js_delete :destroy, id: teacher
          flash_destroyed?
        end
      end

      describe 'XHR GET #recovery' do
        let(:get_recovery) { gaku_js_get :recovery, id: deleted_teacher }

        it 'is successfull' do
          get_recovery
          should respond_with(200)
        end

        it 'assigns  @teacher' do
          get_recovery
          expect(assigns(:teacher)).to eq deleted_teacher
        end

        it 'renders :recovery' do
          get_recovery
          should render_template :recovery
        end

        it 'updates :deleted attribute' do
          expect do
            get_recovery
            deleted_teacher.reload
          end.to change(deleted_teacher, :deleted)
        end
      end

    end
  end

end
