require 'spec_helper_controllers'

describe Gaku::SyllabusesController do

  let(:syllabus) { create(:syllabus) }
  let(:deleted_syllabus) { create(:syllabus, deleted: true) }

  context 'as admin' do
    before { as :admin }

    context 'html' do

      describe 'PATCH #soft_delete' do
        let(:patch_soft_delete) { gaku_patch :soft_delete, id: syllabus }

        it 'redirects' do
          patch_soft_delete
          should respond_with(302)
        end

        it 'assigns  @syllabus' do
          patch_soft_delete
          expect(assigns(:syllabus)).to eq syllabus
        end

        it 'updates :deleted attribute' do
          expect do
            patch_soft_delete
            syllabus.reload
          end.to change(syllabus, :deleted)
        end
      end

    end

    context 'js' do

      describe 'JS PATCH #recovery' do
        let(:js_patch_recovery) { gaku_js_patch :recovery, id: deleted_syllabus }

        it 'is successfull' do
          js_patch_recovery
          should respond_with(200)
        end

        it 'assigns  @syllabus' do
          js_patch_recovery
          expect(assigns(:syllabus)).to eq deleted_syllabus
        end

        it 'renders :recovery' do
          js_patch_recovery
          should render_template :recovery
        end

        it 'updates :deleted attribute' do
          expect do
            js_patch_recovery
            deleted_syllabus.reload
          end.to change(deleted_syllabus, :deleted)
        end
      end

      describe 'JS DELETE #destroy' do
        it 'deletes the syllabus' do
          syllabus
          expect do
            gaku_js_delete :destroy, id: syllabus
          end.to change(Gaku::Syllabus, :count).by(-1)
        end

        it 'decrements @count' do
          gaku_js_delete :destroy, id: syllabus
          expect(assigns(:count)).to eq 0
        end

        it 'sets flash' do
          gaku_js_delete :destroy, id: syllabus
          flash_destroyed?
        end
      end
    end

  end
end
