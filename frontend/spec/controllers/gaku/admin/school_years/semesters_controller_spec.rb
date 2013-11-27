require 'spec_helper_controllers'

describe Gaku::Admin::SchoolYears::SemestersController do

  let(:school_year) { create(:school_year) }
  let(:semester) { create(:semester, starting: Time.now, ending: Time.now + 1.year) }
  let(:invalid_semester) { create(:invalid_semester) }

  context 'as admin' do
    before { as :admin }

    context 'js' do

      describe 'XHR #new' do
        before { gaku_js_get :new, school_year_id: school_year }

        it { should respond_with 200 }
        it('assigns @semester') { expect(assigns(:semester)).to be_a_new(Gaku::Semester) }
        it('renders the :new template') { template? :new }
      end

      describe 'POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create, school_year_id: school_year.id,  semester: attributes_for(:semester)
          end

          it 'creates new semester' do
            expect do
              valid_js_create
            end.to change(Gaku::SchoolYear, :count).by(1)
          end

          xit 'renders flash' do
            valid_js_create
            flash_created?
          end

          xit 'increments @count' do
            valid_js_create
            expect(assigns(:count)).to eq 1
          end
        end

        context 'with invalid attributes' do
          let(:invalid_js_create) do
            gaku_js_post :create, school_year_id: school_year, semester: attributes_for(:invalid_semester)
          end

          xit 'does not save the new semester' do
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
        before { gaku_js_get :edit, id: semester, school_year_id: school_year }

        it { should respond_with 200 }
        it('assigns @semester') { expect(assigns(:semester)).to eq semester }
        it('renders the :edit template') { template? :edit }
      end

      describe 'PATCH #update' do
        context 'with valid attributes' do
          let(:time_starting) { Time.now - 1.year }
          let(:js_patch) do
            gaku_js_patch :update, id: semester, school_year_id: school_year, semester: attributes_for(:semester, starting: time_starting)
          end

          before { js_patch }

          it { should respond_with 200 }
          it('assigns @semester') { expect(assigns(:semester)).to eq semester }
          it('sets flash') { flash_updated? }
          xit("changes semester's attributes") do
            expect do
              gaku_js_patch :update, id: semester,school_year_id: school_year, semester: attributes_for(:semester, starting: time_starting - 2.years, ending: Time.now)
            end.to change(semester.reload, :starting)
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_js_patch :update, id: semester, school_year_id: school_year, semester: attributes_for(:invalid_semester)
          end

          it { should respond_with 200 }
          it('assigns @semester') { expect(assigns(:semester)).to eq semester }

          it "does not change semester's attributes" do
            semester.reload
            expect(semester.starting).not_to eq ''
          end
        end
      end

      describe 'XHR DELETE #destroy' do
        before { school_year.semesters << semester }

        xit 'deletes the semester' do
          semester
          expect do
            gaku_js_delete :destroy, id: semester, school_year_id: school_year.id
          end.to change(Gaku::SchoolYear, :count).by(-1)
        end

        it 'decrements @count' do
          gaku_js_delete :destroy, id: semester, school_year_id: school_year.id
          expect(assigns(:count)).to eq 0
        end

        it 'sets flash' do
          gaku_js_delete :destroy, id: semester, school_year_id: school_year.id
          flash_destroyed?
        end
      end

    end

  end
end
