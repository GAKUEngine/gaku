require 'spec_helper_controllers'

describe Gaku::Students::StudentSpecialtiesController, type: :controller  do

  let(:student) { create(:student) }
  let!(:specialty) { create(:specialty) }
  let(:student_specialty) { create(:student_specialty, student: student, specialty: specialty) }

  context 'as admin' do
    before { as :admin }

    context 'JS' do

      describe 'XHR GET #index' do
        before do
          student_specialty
          gaku_js_get :index, student_id: student.id
        end

        it { should respond_with 200 }
        it('assigns @student_specialties') { expect(assigns(:student_specialties)).to eq [student_specialty] }
        it('assigns @count') { expect(assigns(:count)).to eq 1 }
        it('renders :index template') { template? :index }
      end

      describe 'XHR GET #new' do
        before { gaku_js_get :new, student_id: student.id }

        it { should respond_with 200 }
        it('assigns @student_specialty') { expect(assigns(:student_specialty)).to be_a_new(Gaku::StudentSpecialty) }
        it('assigns @specialties') { expect(assigns(:specialties)).to_not be_empty }
        it('renders the :new template') { template? :new }
      end

      describe 'XHR POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create,
                         student_specialty: attributes_for(:student_specialty, specialty_id: specialty.id),
                         student_id: student.id
          end

          it 'creates new student_specialty' do
            expect do
              expect do
                valid_js_create
              end.to change(Gaku::StudentSpecialty, :count).by(1)
            end.to change(student.student_specialties, :count).by(1)
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

      end

      describe 'XHR GET #edit' do
        before { gaku_js_get :edit, id: student_specialty, student_id: student.id }

        it { should respond_with 200 }
        it('assigns @student_specialty') { expect(assigns(:student_specialty)).to eq student_specialty }
        it('assigns @specialties') { expect(assigns(:specialties)).to_not be_empty }
        it('renders the :edit template') { template? :edit }
      end

      describe 'XHR PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_js_patch :update,
                          id: student_specialty,
                          student_specialty: attributes_for(:student_specialty, specialty_id: specialty),
                          student_id: student.id
          end

          it { should respond_with 200 }
          it('assigns @student_specialty') { expect(assigns(:student_specialty)).to eq student_specialty }
          it('sets flash') { flash_updated? }
          it "changes student_specialty's attributes" do
            student_specialty.reload
            expect(student_specialty.specialty_id).to eq specialty.id
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_js_patch :update,
                          id: student_specialty,
                          student_specialty: attributes_for(:invalid_student_specialty, specialty_id: nil),
                          student_id: student.id
          end

          it { should respond_with 200 }
          it('assigns @student_specialty') { expect(assigns(:student_specialty)).to eq student_specialty }

          it "does not change student_specialty's attributes" do
            student_specialty.reload
            expect(student_specialty.specialty_id).not_to eq nil
          end
        end
      end

      describe 'XHR DELETE #destroy' do

        let(:js_delete) { gaku_js_delete :destroy, id: student_specialty, student_id: student.id }

        it 'deletes the student_specialty' do
          student_specialty
          expect do
            js_delete
          end.to change(Gaku::StudentSpecialty, :count).by(-1)
        end

        it 'decrements @count' do
          js_delete
          expect(assigns(:count)).to eq 0
        end

        it 'sets flash' do
          js_delete
          flash_destroyed?
        end
      end

    end
  end

end
