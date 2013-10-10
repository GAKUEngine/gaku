require 'spec_helper'

describe Gaku::ContactsController do

  let!(:contact_type) { create(:contact_type) }
  let(:contact) { create(:contact, contactable: student, contact_type: contact_type) }
  let(:invalid_contact) { create(:invalid_contact, contactable: student) }
  let!(:student) { create(:student) }

  context 'as admin', type: :contact do
    before { as :admin }

    context 'js' do

      describe 'XHR #new' do
        before { gaku_js_get :new, student_id: student.id }

        it { should respond_with 200 }
        it('assigns @contact') { expect(assigns(:contact)).to be_a_new(Gaku::Contact) }
        it('assigns @contact_types') { expect(assigns(:contact_types)).to eq [contact_type] }
        it('assigns @polymorphic_resource_name') { expect(assigns(:polymorphic_resource_name)).to eq 'student-contact' }
        it('assigns @polymorphic_resource') { expect(assigns(:polymorphic_resource)).to eq student }
        it('assigns @nested_resources') { expect(assigns(:nested_resources)).to eq [] }
        it('renders the :new template') { template? :new }
      end

      describe 'XHR POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create, contact: attributes_for(:contact, contact_type_id: contact_type.id), student_id: student.id
          end

          it 'creates new contact' do
            expect do
              valid_js_create
            end.to change(Gaku::Contact, :count).by(1)
          end

          it 'renders flash' do
            valid_js_create
            flash_created?
          end

          it 'increments @count' do
            valid_js_create
            expect(assigns(:count)).to eq 1
          end

          it 'assigns @polymorphic_resource_name' do
            valid_js_create
            expect(assigns(:polymorphic_resource_name)).to eq 'student-contact'
          end

          it 'assigns @polymorphic_resource' do
            valid_js_create
            expect(assigns(:polymorphic_resource)).to eq student
          end

          it 'assigns @nested_resources' do
            valid_js_create
            expect(assigns(:nested_resources)).to eq []
          end
        end

        context 'with invalid attributes' do
          let(:invalid_js_create) do
            gaku_js_post :create, contact: attributes_for(:invalid_contact, contact_type_id: contact_type.id), student_id: student.id
          end

          it 'does not save the new contact' do
            expect do
              invalid_js_create
            end.to_not change(Gaku::Contact, :count)
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

      describe 'XHR #edit' do
        before { gaku_js_get :edit, id: contact.id, student_id: student.id }

        it { should respond_with 200 }
        it('assigns @contact') { expect(assigns(:contact)).to eq contact }
        it('assigns @contact_types') { expect(assigns(:contact_types)).to eq [contact_type] }
        it('assigns @polymorphic_resource_name') { expect(assigns(:polymorphic_resource_name)).to eq 'student-contact' }
        it('assigns @polymorphic_resource') { expect(assigns(:polymorphic_resource)).to eq student }
        it('assigns @nested_resources') { expect(assigns(:nested_resources)).to eq [] }
        it('renders the :edit template') { template? :edit }
      end

      describe 'PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_js_patch :update, id: contact.id, student_id: student.id, contact: attributes_for(:contact, data: 'mobifon')
          end

          it { should respond_with 200 }
          it('assigns @contact') { expect(assigns(:contact)).to eq contact }
          it('assigns @polymorphic_resource_name') { expect(assigns(:polymorphic_resource_name)).to eq 'student-contact' }
          it('assigns @polymorphic_resource') { expect(assigns(:polymorphic_resource)).to eq student }
          it('assigns @nested_resources') { expect(assigns(:nested_resources)).to eq [] }
          it('sets flash') { flash_updated? }
          it "changes contact's attributes" do
            expect(contact.reload.data).to eq 'mobifon'
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_js_patch :update, id: contact.id, student_id: student.id, contact: attributes_for(:invalid_contact, data: '')
          end

          it { should respond_with 200 }
          it('assigns @contact') { expect(assigns(:contact)).to eq contact }

          it "does not change contact's attributes" do
            expect(contact.reload.data).not_to eq ''
          end
        end
      end

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
        let(:js_get_recovery) { gaku_js_patch :recovery, id: contact.id, student_id: student.id }

        it 'is successfull' do
          js_get_recovery
          should respond_with(200)
        end

        it 'assigns  @contact' do
          js_get_recovery
          expect(assigns(:contact)).to eq contact
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
          contact.soft_delete
          expect do
            js_get_recovery
            contact.reload
          end.to change(contact, :deleted)
        end
      end

    end
  end

end
