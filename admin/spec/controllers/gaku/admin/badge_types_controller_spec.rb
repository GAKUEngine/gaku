require 'spec_helper_controllers'

describe Gaku::Admin::BadgeTypesController do

  let(:badge_type) { create(:badge_type) }
  let(:invalid_badge_type) { create(:invalid_badge_type) }

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
          badge_type
          gaku_get :index
        end

        it { should respond_with 200 }
        it('assigns @badge_types') { expect(assigns(:badge_types)).to eq [badge_type] }
        it('assigns @count') { expect(assigns(:count)).to eq 1 }
        it('renders :index template') { template? :index }
      end

      describe 'POST #create' do
        context 'with valid attributes' do
          let(:valid_create) do
            gaku_post :create, badge_type: attributes_for(:badge_type)
          end

          it 'creates new badge_type' do
            expect do
              valid_create
            end.to change(Gaku::BadgeType, :count).by(1)
          end

          it 'renders flash' do
            valid_create
            flash_created?
          end
        end

        context 'with invalid attributes' do
          let(:invalid_create) do
            gaku_post :create, badge_type: attributes_for(:invalid_badge_type)
          end

          it 'redirects' do
            invalid_create
            should respond_with 302
          end

          it 'does not save the new badge_type' do
            expect do
              invalid_create
            end.to_not change(Gaku::BadgeType, :count)
          end

        end
      end

      describe 'PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_patch :update, id: badge_type, badge_type: attributes_for(:badge_type, name: 'Ruby Champion')
          end

          it { should respond_with 302 }
          it('assigns @badge_type') { expect(assigns(:badge_type)).to eq badge_type }
          it('sets flash') { flash_updated? }
          it "changes badge_type's attributes" do
            badge_type.reload
            expect(badge_type.name).to eq 'Ruby Champion'
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_patch :update, id: badge_type, badge_type: attributes_for(:invalid_badge_type, description: 'Ruby Champion')
          end

          it { should respond_with 302 }
          it('assigns @badge_type') { expect(assigns(:badge_type)).to eq badge_type }

          it "does not change badge_type's attributes" do
            expect(badge_type.reload.description).not_to eq 'Ruby Champion'
          end
        end

      end
    end

    context 'js' do

      describe 'XHR #new' do
        before { gaku_js_get :new }

        it { should respond_with 200 }
        it('assigns @badge_type') { expect(assigns(:badge_type)).to be_a_new(Gaku::BadgeType) }
        it('renders the :new template') { template? :new }
      end

      describe 'XHR #edit' do
        before { gaku_js_get :edit, id: badge_type }

        it { should respond_with 200 }
        it('assigns @badge_type') { expect(assigns(:badge_type)).to eq badge_type }
        it('renders the :edit template') { template? :edit }
      end

      describe 'XHR DELETE #destroy' do
        it 'deletes the badge_type' do
          badge_type
          expect do
            gaku_js_delete :destroy, id: badge_type
          end.to change(Gaku::BadgeType, :count).by(-1)
        end

        it 'assigns @count' do
          gaku_js_delete :destroy, id: badge_type
          expect(assigns(:count)).to_not be_nil
        end
      end

    end

  end
end
