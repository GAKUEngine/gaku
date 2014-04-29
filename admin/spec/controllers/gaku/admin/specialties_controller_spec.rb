require 'spec_helper_controllers'

describe Gaku::Admin::SpecialtiesController do

  let(:specialty) { create(:specialty) }
  let(:invalid_specialty) { create(:invalid_specialty) }
  let(:department) { create(:department) }

  context 'as student' do
    before { as :student }

    describe 'XHR GET #index' do
      before { gaku_js_get :index }

      it { should respond_with 302 }
      it('redirects') { redirect_to? gaku.root_path }
      it('sets unauthorized flash') { flash_unauthorized? }
    end
  end

  context 'as admin' do
    before { as :admin }

    context 'js' do

      describe 'XHR GET #index' do
        before do
          specialty
          gaku_js_get :index
        end

        it { should respond_with 200 }
        it('assigns @specialties') { expect(assigns(:specialties)).to eq [specialty] }
        it('assigns @count') { expect(assigns(:count)).to eq 1 }
        it('renders :index template') { template? :index }
      end

      describe 'XHR #new' do
        before do
          department
          gaku_js_get :new
        end

        it { should respond_with 200 }
        it('assigns @specialty') { expect(assigns(:specialty)).to be_a_new(Gaku::Specialty) }
        it('renders the :new template') { template? :new }
        it('assigns @departments') { expect(assigns(:departments)).to eq [department] }

      end

      describe 'POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create, specialty: attributes_for(:specialty)
          end

          it 'creates new specialty' do
            expect do
              valid_js_create
            end.to change(Gaku::Specialty, :count).by(1)
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
            gaku_js_post :create, specialty: attributes_for(:invalid_specialty)
          end

          it 'does not save the new specialty' do
            expect do
              invalid_js_create
            end.to_not change(Gaku::Specialty, :count)
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
        before do
          department
          gaku_js_get :edit, id: specialty
        end

        it { should respond_with 200 }
        it('assigns @specialty') { expect(assigns(:specialty)).to eq specialty }
        it('renders the :edit template') { template? :edit }
        it('assigns @departments') { expect(assigns(:departments)).to eq [department] }
      end

      describe 'PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_js_patch :update, id: specialty, specialty: attributes_for(:specialty, name: 'Ruby dev')
          end

          it { should respond_with 200 }
          it('assigns @specialty') { expect(assigns(:specialty)).to eq specialty }
          it('sets flash') { flash_updated? }
          it "changes specialty's attributes" do
            specialty.reload
            expect(specialty.name).to eq 'Ruby dev'
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_js_patch :update, id: specialty, specialty: attributes_for(:invalid_specialty, name: '')
          end

          it { should respond_with 200 }
          it('assigns @specialty') { expect(assigns(:specialty)).to eq specialty }

          it "does not change specialty's attributes" do
            specialty.reload
            expect(specialty.name).not_to eq ''
          end
        end
      end

      describe 'XHR DELETE #destroy' do
        it 'deletes the specialty' do
          specialty
          expect do
            gaku_js_delete :destroy, id: specialty
          end.to change(Gaku::Specialty, :count).by(-1)
        end

        it 'decrements @count' do
          gaku_js_delete :destroy, id: specialty
          expect(assigns(:count)).to eq 0
        end

        it 'sets flash' do
          gaku_js_delete :destroy, id: specialty
          flash_destroyed?
        end
      end

    end

  end
end
