require 'spec_helper_controllers'

describe Gaku::ContactsController do

  let!(:contact_type) { create(:contact_type) }
  let(:contact) { create(:contact, contactable: student, contact_type: contact_type) }
  let(:deleted_contact) { create(:contact, contactable: student, contact_type: contact_type, deleted: true) }
  let!(:student) { create(:student) }

  context 'as admin', type: :contact do
    before { as :admin }

    context 'js' do

      describe 'XHR DELETE #destroy' do

        let(:js_delete) { gaku_js_delete :destroy, id: contact.id, student_id: student.id }

        it 'deletes the contact' do
          contact
          expect do
            js_delete
          end.to change(Gaku::Contact, :count).by(-1)
        end

        it 'assigns @polymorphic_resource_name' do
          js_delete
          expect(assigns(:polymorphic_resource_name)).to eq 'student-contact'
        end

        it 'assigns @polymorphic_resource' do
          js_delete
          expect(assigns(:polymorphic_resource)).to eq student
        end

        it 'assigns @nested_resources' do
          js_delete
          expect(assigns(:nested_resources)).to eq []
        end

        it 'decrements @count' do
          js_delete
          expect(assigns(:count)).to eq 0
        end

        it 'sets flash' do
          js_delete
          flash_destroyed?
        end
      end

      describe 'XHR PATCH #soft_delete' do
        let(:js_get_soft_delete) { gaku_js_patch :soft_delete, id: contact.id, student_id: student.id }

        it 'redirects' do
          js_get_soft_delete
          should respond_with(200)
        end

        it 'assigns  @contact' do
          js_get_soft_delete
          expect(assigns(:contact)).to eq contact
        end

        it 'assigns @polymorphic_resource_name' do
          js_get_soft_delete
          expect(assigns(:polymorphic_resource_name)).to eq 'student-contact'
        end

        it 'assigns @polymorphic_resource' do
          js_get_soft_delete
          expect(assigns(:polymorphic_resource)).to eq student
        end

        it 'assigns @nested_resources' do
          js_get_soft_delete
          expect(assigns(:nested_resources)).to eq []
        end

        it 'updates :deleted attribute' do
          expect do
            js_get_soft_delete
            contact.reload
          end.to change(contact, :deleted)
        end
      end

      describe 'XHR PATCH #recovery' do
        let(:js_get_recovery) { gaku_js_patch :recovery, id: deleted_contact.id, student_id: student.id }

        it 'is successfull' do
          js_get_recovery
          should respond_with(200)
        end

        it 'assigns  @contact' do
          js_get_recovery
          expect(assigns(:contact)).to eq deleted_contact
        end

        it 'assigns @polymorphic_resource_name' do
          js_get_recovery
          expect(assigns(:polymorphic_resource_name)).to eq 'student-contact'
        end

        it 'assigns @polymorphic_resource' do
          js_get_recovery
          expect(assigns(:polymorphic_resource)).to eq student
        end

        it 'assigns @nested_resources' do
          js_get_recovery
          expect(assigns(:nested_resources)).to eq []
        end

        it 'renders :recovery' do
          js_get_recovery
          should render_template :recovery
        end

        it 'updates :deleted attribute' do
          expect do
            js_get_recovery
            deleted_contact.reload
          end.to change(deleted_contact, :deleted)
        end
      end

    end
  end

end
