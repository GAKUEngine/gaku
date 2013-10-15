require 'spec_helper'

describe Gaku::Admin::DepartmentsController do

  let(:department) { create(:department) }
  let(:invalid_department) { create(:invalid_department) }

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
          department
          gaku_get :index
        end

        it { should respond_with 200 }
        it('assigns @departments') { expect(assigns(:departments)).to eq [department] }
        it('assigns @count') { expect(assigns(:count)).to eq 1 }
        it('renders :index template') { template? :index }
      end

    end

    context 'js' do

      describe 'XHR #new' do
        before { gaku_js_get :new }

        it { should respond_with 200 }
        it('assigns @department') { expect(assigns(:department)).to be_a_new(Gaku::Department) }
        it('renders the :new template') { template? :new }
      end

      describe 'POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create, department: attributes_for(:department)
          end

          it 'creates new department' do
            expect do
              valid_js_create
            end.to change(Gaku::Department, :count).by(1)
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
            gaku_js_post :create, department: attributes_for(:invalid_department)
          end

          it 'does not save the new department' do
            expect do
              invalid_js_create
            end.to_not change(Gaku::Department, :count)
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
        before { gaku_js_get :edit, id: department }

        it { should respond_with 200 }
        it('assigns @department') { expect(assigns(:department)).to eq department }
        it('renders the :edit template') { template? :edit }
      end

      describe 'PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_js_patch :update, id: department, department: attributes_for(:department, name: 'new type')
          end

          it { should respond_with 200 }
          it('assigns @department') { expect(assigns(:department)).to eq department }
          it('sets flash') { flash_updated? }
          it "changes department's attributes" do
            department.reload
            expect(department.name).to eq 'new type'
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_js_patch :update, id: department, department: attributes_for(:invalid_department, name: '')
          end

          it { should respond_with 200 }
          it('assigns @department') { expect(assigns(:department)).to eq department }

          it "does not change department's attributes" do
            department.reload
            expect(department.name).not_to eq ''
          end
        end
      end

      describe 'XHR DELETE #destroy' do
        it 'deletes the department' do
          department
          expect do
            gaku_js_delete :destroy, id: department
          end.to change(Gaku::Department, :count).by(-1)
        end

        it 'decrements @count' do
          gaku_js_delete :destroy, id: department
          expect(assigns(:count)).to eq 0
        end

        it 'sets flash' do
          gaku_js_delete :destroy, id: department
          flash_destroyed?
        end
      end

    end

  end
end
