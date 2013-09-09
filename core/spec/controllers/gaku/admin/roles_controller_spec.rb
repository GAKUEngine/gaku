require 'spec_helper'

describe Gaku::Admin::RolesController do

  let(:role) { create(:role) }
  let(:invalid_role) { create(:invalid_role) }

  context 'as student' do
    before { as :student }

    describe 'GET #index' do
      before { gaku_get :index }

      it { should respond_with 302 }
      it('redirects') { redirect_to? gaku.root_path }
      it('sets unauthorized flash') { flash_unauthorized? }
    end
  end

  context 'as admin' do
    before { as :admin }

    context 'html' do
      describe 'GET #index' do
        before do
          role
          gaku_get :index
        end

        it { should respond_with 200 }
        it('assigns @roles') { expect(assigns(:roles)).to include(role) }
        it('assigns @count') { expect(assigns(:count)).to eq 2 }
        it('renders :index template') { template? :index }
      end

    end

    context 'js' do

      describe 'XHR #new' do
        before { gaku_js_get :new }

        it { should respond_with 200 }
        it('assigns @role') { expect(assigns(:role)).to be_a_new(Gaku::Role) }
        it('renders the :new template') { template? :new }
      end

      describe 'POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create, role: attributes_for(:role)
          end

          it 'creates new role' do
            expect do
              valid_js_create
            end.to change(Gaku::Role, :count).by(1)
          end

          it 'renders flash' do
            valid_js_create
            flash_created?
          end
        end

        context 'with invalid attributes' do
          let(:invalid_js_create) do
            gaku_js_post :create, role: attributes_for(:invalid_role)
          end

          it 'does not save the new role' do
            expect do
              invalid_js_create
            end.to_not change(Gaku::Role, :count)
          end

          it 're-renders the new method' do
            invalid_js_create
            template? :create
          end
        end
      end

      describe 'XHR #edit' do
        before { gaku_js_get :edit, id: role }

        it { should respond_with 200 }
        it('assigns @role') { expect(assigns(:role)).to eq role }
        it('renders the :edit template') { template? :edit }
      end

      describe 'PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_js_patch :update, id: role, role: attributes_for(:role, name: 'Super Admin')
          end

          it { should respond_with 200 }
          it('assigns @role') { expect(assigns(:role)).to eq role }
          it('sets flash') { flash_updated? }
          it "changes role's attributes" do
            role.reload
            expect(role.name).to eq 'Super Admin'
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_js_patch :update, id: role, role: attributes_for(:invalid_role, name: '')
          end

          it { should respond_with 200 }
          it('assigns @role') { expect(assigns(:role)).to eq role }

          it "does not change role's attributes" do
            role.reload
            expect(role.name).not_to eq ''
          end
        end
      end

      describe 'XHR DELETE #destroy' do
        it 'deletes the role' do
          role
          expect do
            gaku_js_delete :destroy, id: role
          end.to change(Gaku::Role, :count).by(-1)
        end

        it 'assigns @count' do
          gaku_js_delete :destroy, id: role
          expect(assigns(:count)).to_not be_nil
        end
      end

    end

  end
end
