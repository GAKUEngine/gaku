require 'spec_helper_controllers'

describe Gaku::ExamsController do

  let(:exam) { create(:exam) }
  let(:deleted_exam) { create(:exam, deleted: true) }

  context 'as admin' do
    before { as :admin }

    context 'html' do

      describe 'PATCH #soft_delete' do
        let(:patch_soft_delete) { gaku_patch :soft_delete, id: exam }

        it 'redirects' do
          patch_soft_delete
          should respond_with(302)
        end

        it 'assigns  @exam' do
          patch_soft_delete
          expect(assigns(:exam)).to eq exam
        end

        it 'updates :deleted attribute' do
          expect do
            patch_soft_delete
            exam.reload
          end.to change(exam, :deleted)
        end
      end

    end

    context 'js' do

      describe 'XHR DELETE #destroy' do
        it 'deletes the exam' do
          exam
          expect do
            gaku_js_delete :destroy, id: exam
          end.to change(Gaku::Exam, :count).by(-1)
        end

        it 'decrements @count' do
          gaku_js_delete :destroy, id: exam
          expect(assigns(:count)).to eq 0
        end

        it 'sets flash' do
          gaku_js_delete :destroy, id: exam
          flash_destroyed?
        end
      end

      describe 'XHR GET #recovery' do
        let(:js_patch_recovery) { gaku_js_patch :recovery, id: deleted_exam }

        it 'is successfull' do
          js_patch_recovery
          should respond_with(200)
        end

        it 'assigns  @exam' do
          js_patch_recovery
          expect(assigns(:exam)).to eq deleted_exam
        end

        it 'renders :recovery' do
          js_patch_recovery
          should render_template :recovery
        end

        it 'updates :deleted attribute' do
          expect do
            js_patch_recovery
            deleted_exam.reload
          end.to change(deleted_exam, :deleted)
        end
      end

    end
  end

end
