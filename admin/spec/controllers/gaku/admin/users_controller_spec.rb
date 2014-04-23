require 'spec_helper_controllers'

describe Gaku::Admin::UsersController do

  let(:user) { create(:user) }
  let(:invalid_user) { create(:invalid_user) }

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
          user
          gaku_js_get :index
        end

        it { should respond_with 200 }
        it('assigns @users') { expect(assigns(:users)).to include(user) }
        it('assigns @count') { expect(assigns(:count)).to eq 2 }
        it('renders :index template') { template? :index }
      end

      describe 'XHR #new' do
        before { gaku_js_get :new }

        it { should respond_with 200 }
        it('assigns @user') { expect(assigns(:user)).to be_a_new(Gaku::User) }
        it('renders the :new template') { template? :new }
      end

      describe 'POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create, user: attributes_for(:user)
          end

          it 'creates new user' do
            expect do
              valid_js_create
            end.to change(Gaku::User, :count).by(1)
          end

          it 'renders flash' do
            valid_js_create
            flash_created?
          end

          it 'increments @count' do
            valid_js_create
            expect(assigns(:count)).to eq 2
          end
        end

        context 'with invalid attributes' do
          let(:invalid_js_create) do
            gaku_js_post :create, user: attributes_for(:invalid_user)
          end

          it 'does not save the new user' do
            expect do
              invalid_js_create
            end.to_not change(Gaku::User, :count)
          end

          it 're-renders the new method' do
            invalid_js_create
            template? :create
          end

          it "doesn't increment @count" do
            invalid_js_create
            expect(assigns(:count)).to eq 1
          end
        end
      end

      describe 'XHR #edit' do
        before { gaku_js_get :edit, id: user }

        it { should respond_with 200 }
        it('assigns @user') { expect(assigns(:user)).to eq user }
        it('renders the :edit template') { template? :edit }
      end

      describe 'PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_js_patch :update, id: user, user: attributes_for(:user, email: 'new@example.com')
          end

          it { should respond_with 200 }
          it('assigns @user') { expect(assigns(:user)).to eq user }
          it('sets flash') { flash_updated? }
          it "changes user's attributes" do
            user.reload
            expect(user.email).to eq 'new@example.com'
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_js_patch :update, id: user, user: attributes_for(:invalid_user, email: '')
          end

          it { should respond_with 200 }
          it('assigns @user') { expect(assigns(:user)).to eq user }

          it "does not change user's attributes" do
            user.reload
            expect(user.email).not_to eq ''
          end
        end
      end

      describe 'XHR DELETE #destroy' do
        it 'deletes the user' do
          user
          expect do
            gaku_js_delete :destroy, id: user
          end.to change(Gaku::User, :count).by(-1)
        end

        it 'decrements @count' do
          gaku_js_delete :destroy, id: user
          expect(assigns(:count)).to eq 1
        end

        it 'sets flash' do
          gaku_js_delete :destroy, id: user
          flash_destroyed?
        end
      end

    end

  end
end
