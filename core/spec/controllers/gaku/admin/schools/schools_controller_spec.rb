require 'spec_helper'

describe Gaku::Admin::SchoolsController do

  let(:school) { create(:school, primary: false) }
  let(:master_school) { create(:school, primary: true) }

  context 'permissions' do
    ensures 'deny except', :admin
  end

 context 'as admin' do
    before { as :admin }

    context 'html' do

      describe 'GET #index' do
        before do
          school
          gaku_get :index
        end

        it { should respond_with 200 }
        it('assigns @schools') { expect(assigns(:schools)).to eq [school] }
        it('assigns @count') { expect(assigns(:count)).to eq 1 }
        it('renders :index template') { template? :index }
      end

      describe 'GET #edit' do
        before { gaku_get :edit, id: school }

        it { should respond_with 200 }
        it('assigns @school') { expect(assigns(:school)).to eq school }
        it('renders the :edit template') { template? :edit }
      end

      describe 'GET #edit_master' do
        before { gaku_get :edit_master, id: master_school }

        it { should respond_with 200 }
        it('assigns @school') { expect(assigns(:school)).to eq master_school }
        it('renders the :edit_master template') { template? :edit_master }
      end

      describe 'GET #show' do
        before { gaku_get :show, id: school }

        it { should respond_with 200 }
        it('assigns @school') { expect(assigns(:school)).to eq school }
        it('renders the :show template') { template? :show }
      end

      describe 'GET #show_master' do
        before { gaku_get :show_master, id: master_school }

        it { should respond_with 200 }
        it('assigns @school') { expect(assigns(:school)).to eq master_school }
        it('renders the :show_master template') { template? :show_master }
      end

      describe 'PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_patch :update, id: school, school: attributes_for(:school, name: 'test')
          end

          it { should respond_with 302 }
          it('redirects to :edit view') { redirect_to? "/admin/schools/#{school.id}/edit"}
          it('assigns @school') { expect(assigns(:school)).to eq school }
          it('sets flash') { flash_updated? }
          it "changes school's attributes" do
            school.reload
            expect(school.name).to eq 'test'
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_patch :update, id: school, school: attributes_for(:invalid_school, name: '')
          end

          it { should respond_with 200 }
          it('assigns @school') { expect(assigns(:school)).to eq school }

          it "does not change school's attributes" do
            school.reload
            expect(school.name).not_to eq ''
          end
        end
      end

      describe 'PATCH #update_master' do
        context 'with valid attributes' do
          before do
            gaku_patch :update_master, id: master_school, school: attributes_for(:school, name: 'test')
          end

          it { should respond_with 302 }
          it('redirects to :edit_master view') { redirect_to? "/admin/school_details/edit"}
          it('assigns @school') { expect(assigns(:school)).to eq master_school }
          it('sets flash') { flash_updated? }
          it "changes school's attributes" do
            master_school.reload
            expect(master_school.name).to eq 'test'
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_patch :update, id: master_school, school: attributes_for(:invalid_school, name: '')
          end

          it { should respond_with 200 }
          it('assigns @school') { expect(assigns(:school)).to eq master_school }

          it "does not change school's attributes" do
            master_school.reload
            expect(master_school.name).not_to eq ''
          end
        end
      end

    end

    context 'js' do

      describe 'JS #new' do
        before { gaku_js_get :new }

        it { should respond_with 200 }
        it('assigns @school') { expect(assigns(:school)).to be_a_new(Gaku::School) }
        it('renders the :new template') { template? :new }
      end

      describe 'JS POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create, school: attributes_for(:school)
          end

          it 'creates new school' do
            expect do
              valid_js_create
            end.to change(Gaku::School, :count).by(1)
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
            gaku_js_post :create, school: attributes_for(:invalid_school)
          end

          it 'does not save the new school' do
            expect do
              invalid_js_create
            end.to_not change(Gaku::School, :count)
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

      describe 'JS DELETE #destroy' do
        it 'deletes the school' do
          school
          expect do
            gaku_js_delete :destroy, id: school
          end.to change(Gaku::School, :count).by(-1)
        end

        it 'decrements @count' do
          gaku_js_delete :destroy, id: school
          expect(assigns(:count)).to eq 0
        end

        it 'sets flash' do
          gaku_js_delete :destroy, id: school
          flash_destroyed?
        end
      end

    end
  end


end
