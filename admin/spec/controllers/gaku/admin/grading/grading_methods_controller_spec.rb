require 'spec_helper_controllers'

describe Gaku::Admin::GradingMethodsController do

  let(:grading_method) { create(:grading_method) }
  let(:invalid_grading_method) { create(:invalid_grading_method) }

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
          grading_method
          gaku_js_get :index
        end

        it { should respond_with 200 }
        it('assigns @grading_methods') { expect(assigns(:grading_methods)).to eq [grading_method] }
        it('assigns @count') { expect(assigns(:count)).to eq 1 }
        it('renders :index template') { template? :index }
      end

      describe 'XHR #new' do
        before { gaku_js_get :new }

        it { should respond_with 200 }
        it('assigns @grading_method') { expect(assigns(:grading_method)).to be_a_new(Gaku::GradingMethod) }
        it('renders the :new template') { template? :new }
      end

      describe 'POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create, grading_method: attributes_for(:grading_method)
          end

          it 'creates new grading_method' do
            expect do
              valid_js_create
            end.to change(Gaku::GradingMethod, :count).by(1)
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
            gaku_js_post :create, grading_method: attributes_for(:invalid_grading_method)
          end

          it 'does not save the new grading_method' do
            expect do
              invalid_js_create
            end.to_not change(Gaku::GradingMethod, :count)
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
        before { gaku_js_get :edit, id: grading_method }

        it { should respond_with 200 }
        it('assigns @grading_method') { expect(assigns(:grading_method)).to eq grading_method }
        it('renders the :edit template') { template? :edit }
      end

      describe 'PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_js_patch :update, id: grading_method, grading_method: attributes_for(:grading_method, name: 'new method')
          end

          it { should respond_with 200 }
          it('assigns @grading_method') { expect(assigns(:grading_method)).to eq grading_method }
          it('sets flash') { flash_updated? }
          it "changes grading_method's attributes" do
            grading_method.reload
            expect(grading_method.name).to eq 'new method'
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_js_patch :update, id: grading_method, grading_method: attributes_for(:invalid_grading_method, name: '')
          end

          it { should respond_with 200 }
          it('assigns @grading_method') { expect(assigns(:grading_method)).to eq grading_method }

          it "does not change grading_method's attributes" do
            grading_method.reload
            expect(grading_method.name).not_to eq ''
          end
        end
      end

      describe 'XHR DELETE #destroy' do
        it 'deletes the grading_method' do
          grading_method
          expect do
            gaku_js_delete :destroy, id: grading_method
          end.to change(Gaku::GradingMethod, :count).by(-1)
        end

        it 'decrements @count' do
          gaku_js_delete :destroy, id: grading_method
          expect(assigns(:count)).to eq 0
        end

        it 'sets flash' do
          gaku_js_delete :destroy, id: grading_method
          flash_destroyed?
        end
      end

    end

  end
end
