require 'spec_helper_controllers'

describe Gaku::Admin::SchoolYearsController do

  let(:school_year) { create(:school_year) }
  let(:invalid_school_year) { create(:invalid_school_year) }

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
          school_year
          gaku_js_get :index
        end

        it { should respond_with 200 }
        it('assigns @school_years') { expect(assigns(:school_years)).to include(school_year) }
        it('assigns @count') { expect(assigns(:count)).to eq 1 }
        it('renders :index template') { template? :index }
      end

      describe 'XHR #new' do
        before { gaku_js_get :new }

        it { should respond_with 200 }
        it('assigns @school_year') { expect(assigns(:school_year)).to be_a_new(Gaku::SchoolYear) }
        it('renders the :new template') { template? :new }
      end

      describe 'POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create, school_year: attributes_for(:school_year)
          end

          it 'creates new school_year' do
            expect do
              valid_js_create
            end.to change(Gaku::SchoolYear, :count).by(1)
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
            gaku_js_post :create, school_year: attributes_for(:invalid_school_year)
          end

          it 'does not save the new school_year' do
            expect do
              invalid_js_create
            end.to_not change(Gaku::SchoolYear, :count)
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
        before { gaku_js_get :edit, id: school_year }

        it { should respond_with 200 }
        it('assigns @school_year') { expect(assigns(:school_year)).to eq school_year }
        it('renders the :edit template') { template? :edit }
      end

      describe 'PATCH #update' do
        context 'with valid attributes' do
          let(:time_starting) { Time.now - 1.year }
          let(:js_patch) do
            gaku_js_patch :update, id: school_year, school_year: attributes_for(:school_year, starting: time_starting)
          end

          before { js_patch }

          it { should respond_with 200 }
          it('assigns @school_year') { expect(assigns(:school_year)).to eq school_year }
          it('sets flash') { flash_updated? }
          xit("changes school_year's attributes") do
            expect do
              gaku_js_patch :update, id: school_year,
                                     school_year: attributes_for(:school_year,
                                                                 starting: time_starting - 2.years,
                                                                 ending: Time.now)
            end.to change(school_year.reload, :starting)
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_js_patch :update, id: school_year, school_year: attributes_for(:invalid_school_year)
          end

          it { should respond_with 200 }
          it('assigns @school_year') { expect(assigns(:school_year)).to eq school_year }

          xit "does not change school_year's attributes" do
            school_year.reload
            expect(school_year.starting).not_to eq ''
          end
        end
      end

      describe 'XHR DELETE #destroy' do
        it 'deletes the school_year' do
          school_year
          expect do
            gaku_js_delete :destroy, id: school_year
          end.to change(Gaku::SchoolYear, :count).by(-1)
        end

        it 'decrements @count' do
          gaku_js_delete :destroy, id: school_year
          expect(assigns(:count)).to eq 0
        end

        it 'sets flash' do
          gaku_js_delete :destroy, id: school_year
          flash_destroyed?
        end
      end

    end

  end
end
