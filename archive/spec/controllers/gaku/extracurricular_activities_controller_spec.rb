require 'spec_helper_controllers'

describe Gaku::ExtracurricularActivitiesController do

  let(:extracurricular_activity) { create(:extracurricular_activity) }
  let(:deleted_activity) { create(:extracurricular_activity, deleted: true) }

  context 'as admin' do
    before { as :admin }

    context 'html' do

      describe 'PATCH #soft_delete' do
        let(:patch_soft_delete) { gaku_patch :soft_delete, id: extracurricular_activity }

        it 'redirects' do
          patch_soft_delete
          should respond_with(302)
        end

        it 'assigns  @extracurricular_activity' do
          patch_soft_delete
          expect(assigns(:extracurricular_activity)).to eq extracurricular_activity
        end

        it 'updates :deleted attribute' do
          expect do
            patch_soft_delete
            extracurricular_activity.reload
          end.to change(extracurricular_activity, :deleted)
        end
      end
    end

    context 'js' do

      describe 'XHR GET #recovery' do
        let(:js_patch_recovery) { gaku_js_patch :recovery, id: deleted_activity }

        it 'is successfull' do
          js_patch_recovery
          should respond_with(200)
        end

        it 'assigns  @extracurricular_activity' do
          js_patch_recovery
          expect(assigns(:extracurricular_activity)).to eq deleted_activity
        end

        it 'renders :recovery' do
          js_patch_recovery
          should render_template :recovery
        end

        it 'updates :deleted attribute' do
          expect do
            js_patch_recovery
            deleted_activity.reload
          end.to change(deleted_activity, :deleted)
        end
      end

      describe 'XHR DELETE #destroy' do
        it 'deletes the extracurricular_activity' do
          extracurricular_activity
          expect do
            gaku_js_delete :destroy, id: extracurricular_activity
          end.to change(Gaku::ExtracurricularActivity, :count).by(-1)
        end

        it 'decrements @count' do
          gaku_js_delete :destroy, id: extracurricular_activity
          expect(assigns(:count)).to eq 0
        end

        it 'sets flash' do
          gaku_js_delete :destroy, id: extracurricular_activity
          flash_destroyed?
        end
      end

    end
  end

end
