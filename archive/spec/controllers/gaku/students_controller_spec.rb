require 'spec_helper_controllers'

describe Gaku::StudentsController do

  let(:student) { create(:student) }
  let(:deleted_student) { create(:student, deleted: true) }

  before { as :admin }

  context 'HTML' do

    describe 'PATCH #soft_delete' do
      let(:patch_soft_delete) { gaku_patch :soft_delete, id: student }

      it 'redirects' do
        patch_soft_delete
        should respond_with(302)
      end

      it 'assigns  @student' do
        patch_soft_delete
        expect(assigns(:student)).to eq student
      end

      it 'updates :deleted attribute' do
        expect do
          patch_soft_delete
          student.reload
        end.to change(student, :deleted)
      end
    end

  end

  context 'JS' do

    describe 'JS PATCH #recovery' do
      let(:js_patch_recovery) { gaku_js_patch :recovery, id: deleted_student }

      it 'is successfull' do
        js_patch_recovery
        should respond_with(200)
      end

      it 'assigns  @student' do
        js_patch_recovery
        expect(assigns(:student)).to eq deleted_student
      end

      it 'renders :recovery' do
        js_patch_recovery
        should render_template :recovery
      end

      it 'updates :deleted attribute' do
        expect do
          js_patch_recovery
          deleted_student.reload
        end.to change(deleted_student, :deleted)
      end
    end

    describe 'DELETE #destroy' do
      it 'deletes the student' do
        student
        expect do
          gaku_js_delete :destroy, id: student
        end.to change(Gaku::Student, :count).by(-1)
      end
    end
  end

end
