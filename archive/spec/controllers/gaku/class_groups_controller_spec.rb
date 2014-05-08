require 'spec_helper_controllers'

describe Gaku::ClassGroupsController do

  let(:class_group) { create(:class_group) }
  let(:deleted_class_group) { create(:class_group, deleted: true) }

  context 'as admin' do
    before { as :admin }

    context 'html' do

      describe 'PATCH #soft_delete' do
        let(:patch_soft_delete) { gaku_patch :soft_delete, id: class_group }

        it 'redirects' do
          patch_soft_delete
          should respond_with(302)
        end

        it 'assigns  @class_group' do
          patch_soft_delete
          expect(assigns(:class_group)).to eq class_group
        end

        it 'updates :deleted attribute' do
          expect do
            patch_soft_delete
            class_group.reload
          end.to change(class_group, :deleted)
        end
      end

    end

    context 'js' do

      describe 'JS DELETE #destroy' do
        it 'deletes the class_group' do
          class_group
          expect do
            gaku_js_delete :destroy, id: class_group
          end.to change(Gaku::ClassGroup, :count).by(-1)
        end

        it 'decrements @count' do
          gaku_js_delete :destroy, id: class_group
          expect(assigns(:count)).to eq 0
        end

        it 'sets flash' do
          gaku_js_delete :destroy, id: class_group
          flash_destroyed?
        end
      end

      describe 'JS PATCH #recovery' do
        let(:js_patch_recovery) { gaku_js_patch :recovery, id: deleted_class_group }

        it 'is successfull' do
          js_patch_recovery
          should respond_with(200)
        end

        it 'assigns  @class_group' do
          js_patch_recovery
          expect(assigns(:class_group)).to eq deleted_class_group
        end

        it 'renders :recovery' do
          js_patch_recovery
          should render_template :recovery
        end

        it 'updates :deleted attribute' do
          expect do
            js_patch_recovery
            deleted_class_group.reload
          end.to change(deleted_class_group, :deleted)
        end
      end

    end
  end

end
