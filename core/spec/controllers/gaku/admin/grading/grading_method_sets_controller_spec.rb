require 'spec_helper'

describe Gaku::Admin::GradingMethodSetsController do

  let(:grading_method_set) { create(:grading_method_set, primary: false) }
  let(:invalid_grading_method_set) { create(:invalid_grading_method_set) }

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
          grading_method_set
          gaku_get :index
        end

        it { should respond_with 200 }
        it('assigns @grading_method_sets') { expect(assigns(:grading_method_sets)).to eq [grading_method_set] }
        it('assigns @count') { expect(assigns(:count)).to eq 1 }
        it('renders :index template') { template? :index }
      end

    end

    context 'js' do

      describe 'XHR #new' do
        before { gaku_js_get :new }

        it { should respond_with 200 }
        it('assigns @grading_method_set') { expect(assigns(:grading_method_set)).to be_a_new(Gaku::GradingMethodSet) }
        it('renders the :new template') { template? :new }
      end

      describe 'POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create, grading_method_set: attributes_for(:grading_method_set)
          end

          it 'creates new grading_method_set' do
            expect do
              valid_js_create
            end.to change(Gaku::GradingMethodSet, :count).by(1)
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
            gaku_js_post :create, grading_method_set: attributes_for(:invalid_grading_method_set)
          end

          it 'does not save the new grading_method_set' do
            expect do
              invalid_js_create
            end.to_not change(Gaku::GradingMethodSet, :count)
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
        before { gaku_js_get :edit, id: grading_method_set }

        it { should respond_with 200 }
        it('assigns @grading_method_set') { expect(assigns(:grading_method_set)).to eq grading_method_set }
        it('renders the :edit template') { template? :edit }
      end

      describe 'PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_js_patch :update, id: grading_method_set, grading_method_set: attributes_for(:grading_method_set, name: 'new method')
          end

          it { should respond_with 200 }
          it('assigns @grading_method_set') { expect(assigns(:grading_method_set)).to eq grading_method_set }
          it('sets flash') { flash_updated? }
          it "changes grading_method_set's attributes" do
            grading_method_set.reload
            expect(grading_method_set.name).to eq 'new method'
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_js_patch :update, id: grading_method_set, grading_method_set: attributes_for(:invalid_grading_method_set, name: '')
          end

          it { should respond_with 200 }
          it('assigns @grading_method_set') { expect(assigns(:grading_method_set)).to eq grading_method_set }

          it "does not change grading_method_set's attributes" do
            grading_method_set.reload
            expect(grading_method_set.name).not_to eq ''
          end
        end
      end

      describe 'XHR DELETE #destroy' do
        it 'deletes the grading_method_set' do
          grading_method_set
          expect do
            gaku_js_delete :destroy, id: grading_method_set
          end.to change(Gaku::GradingMethodSet, :count).by(-1)
        end

        it 'decrements @count' do
          gaku_js_delete :destroy, id: grading_method_set
          expect(assigns(:count)).to eq 0
        end

        it 'sets flash' do
          gaku_js_delete :destroy, id: grading_method_set
          flash_destroyed?
        end
      end

      describe 'POST #make_primary' do
        before { create(:grading_method_set, primary: true) }

        let(:valid_js_make_primary) do
          gaku_js_post :make_primary, id: grading_method_set
        end

        it 'responds with 200' do
          valid_js_make_primary
          should respond_with 200
        end

        it('assigns @grading_method_set') do
          valid_js_make_primary
          expect(assigns(:grading_method_set)).to eq grading_method_set
        end

        it 'makes primary' do
          expect(grading_method_set.reload.primary).to eq false
          valid_js_make_primary
          expect(grading_method_set.reload.primary).to eq true
        end

        it('renders the :make_primary template')  do
          valid_js_make_primary
          template? :make_primary
        end
      end

    end

  end
end
