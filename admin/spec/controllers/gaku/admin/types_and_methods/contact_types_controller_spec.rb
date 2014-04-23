require 'spec_helper_controllers'

describe Gaku::Admin::ContactTypesController do

  let(:contact_type) { create(:contact_type) }
  let(:invalid_contact_type) { create(:invalid_contact_type) }

  context 'as student' do
    before { as :student }

    describe 'XHR #index' do
      before { gaku_js_get :index }

      it { should respond_with 302 }
      it('redirects') { redirect_to? gaku.root_path }
      it('sets unauthorized flash') { flash_unauthorized? }
    end
  end

  context 'as admin' do
    before { as :admin }

    context 'js' do

      describe 'XHR #index' do
        before do
          contact_type
          gaku_js_get :index
        end

        it { should respond_with 200 }
        it('assigns @contact_types') { expect(assigns(:contact_types)).to eq [contact_type] }
        it('assigns @count') { expect(assigns(:count)).to eq 1 }
        it('renders :index template') { template? :index }
      end

      describe 'XHR #new' do
        before { gaku_js_get :new }

        it { should respond_with 200 }
        it('assigns @contact_type') { expect(assigns(:contact_type)).to be_a_new(Gaku::ContactType) }
        it('renders the :new template') { template? :new }
      end

      describe 'POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create, contact_type: attributes_for(:contact_type)
          end

          it 'creates new contact_type' do
            expect do
              valid_js_create
            end.to change(Gaku::ContactType, :count).by(1)
          end

          it 'renders flash' do
            valid_js_create
            flash_created?
          end

          it 'increments @count' do
            valid_js_create
            expect(assigns(:count)).to eq 1
          end
        end

        context 'with invalid attributes' do
          let(:invalid_js_create) do
            gaku_js_post :create, contact_type: attributes_for(:invalid_contact_type)
          end

          it 'does not save the new contact_type' do
            expect do
              invalid_js_create
            end.to_not change(Gaku::ContactType, :count)
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
        before { gaku_js_get :edit, id: contact_type }

        it { should respond_with 200 }
        it('assigns @contact_type') { expect(assigns(:contact_type)).to eq contact_type }
        it('renders the :edit template') { template? :edit }
      end

      describe 'PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_js_patch :update, id: contact_type, contact_type: attributes_for(:contact_type, name: 'mobifon')
          end

          it { should respond_with 200 }
          it('assigns @contact_type') { expect(assigns(:contact_type)).to eq contact_type }
          it('sets flash') { flash_updated? }
          it "changes contact_type's attributes" do
            contact_type.reload
            expect(contact_type.name).to eq 'mobifon'
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_js_patch :update, id: contact_type, contact_type: attributes_for(:invalid_contact_type, name: '')
          end

          it { should respond_with 200 }
          it('assigns @contact_type') { expect(assigns(:contact_type)).to eq contact_type }

          it "does not change contact_type's attributes" do
            contact_type.reload
            expect(contact_type.name).not_to eq ''
          end
        end
      end

      describe 'XHR DELETE #destroy' do
        it 'deletes the contact_type' do
          contact_type
          expect do
            gaku_js_delete :destroy, id: contact_type
          end.to change(Gaku::ContactType, :count).by(-1)
        end

        it 'decrements @count' do
          gaku_js_delete :destroy, id: contact_type
          expect(assigns(:count)).to eq 0
        end

        it 'sets flash' do
          gaku_js_delete :destroy, id: contact_type
          flash_destroyed?
        end
      end

    end

  end
end
