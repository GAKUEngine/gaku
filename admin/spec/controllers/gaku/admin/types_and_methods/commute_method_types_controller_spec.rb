require 'spec_helper_controllers'

describe Gaku::Admin::CommuteMethodTypesController do

  let(:commute_method_type) { create(:commute_method_type) }
  let(:invalid_commute_method_type) { create(:invalid_commute_method_type) }

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
          commute_method_type
          gaku_js_get :index
        end

        it { should respond_with 200 }
        it('assigns @commute_method_types') { expect(assigns(:commute_method_types)).to eq [commute_method_type] }
        it('assigns @count') { expect(assigns(:count)).to eq 1 }
        it('renders :index template') { template? :index }
      end

      describe 'XHR #new' do
        before { gaku_js_get :new }

        it { should respond_with 200 }
        it('assigns @commute_method_type') { expect(assigns(:commute_method_type)).to be_a_new(Gaku::CommuteMethodType) }
        it('renders the :new template') { template? :new }
      end

      describe 'POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create, commute_method_type: attributes_for(:commute_method_type)
          end

          it 'creates new commute_method_type' do
            expect do
              valid_js_create
            end.to change(Gaku::CommuteMethodType, :count).by(1)
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
            gaku_js_post :create, commute_method_type: attributes_for(:invalid_commute_method_type)
          end

          it 'does not save the new commute_method_type' do
            expect do
              invalid_js_create
            end.to_not change(Gaku::CommuteMethodType, :count)
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
        before { gaku_js_get :edit, id: commute_method_type }

        it { should respond_with 200 }
        it('assigns @commute_method_type') { expect(assigns(:commute_method_type)).to eq commute_method_type }
        it('renders the :edit template') { template? :edit }
      end

      describe 'PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_js_patch :update, id: commute_method_type, commute_method_type: attributes_for(:commute_method_type, name: 'new method')
          end

          it { should respond_with 200 }
          it('assigns @commute_method_type') { expect(assigns(:commute_method_type)).to eq commute_method_type }
          it('sets flash') { flash_updated? }
          it "changes commute_method_type's attributes" do
            commute_method_type.reload
            expect(commute_method_type.name).to eq 'new method'
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_js_patch :update, id: commute_method_type, commute_method_type: attributes_for(:invalid_commute_method_type, name: '')
          end

          it { should respond_with 200 }
          it('assigns @commute_method_type') { expect(assigns(:commute_method_type)).to eq commute_method_type }

          it "does not change commute_method_type's attributes" do
            commute_method_type.reload
            expect(commute_method_type.name).not_to eq ''
          end
        end
      end

      describe 'XHR DELETE #destroy' do
        it 'deletes the commute_method_type' do
          commute_method_type
          expect do
            gaku_js_delete :destroy, id: commute_method_type
          end.to change(Gaku::CommuteMethodType, :count).by(-1)
        end

        it 'decrements @count' do
          gaku_js_delete :destroy, id: commute_method_type
          expect(assigns(:count)).to eq 0
        end

        it 'sets flash' do
          gaku_js_delete :destroy, id: commute_method_type
          flash_destroyed?
        end
      end

    end

  end
end
