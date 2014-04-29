require 'spec_helper_controllers'

describe Gaku::Students::SimpleGradesController do

  let(:student) { create(:student) }
  let!(:simple_grade_type) { create(:simple_grade_type) }
  let(:simple_grade) { create(:simple_grade) }

  context 'as admin' do
    before { as :admin }

    context 'JS' do

      describe 'XHR GET #index' do
        before do
          student.simple_grades << simple_grade
          gaku_js_get :index, student_id: student.id
        end

        it { should respond_with 200 }
        it('assigns @simple_grades') { expect(assigns(:simple_grades)).to eq [simple_grade] }
        it('assigns @count') { expect(assigns(:count)).to eq 1 }
        it('renders :index template') { template? :index }
      end

      describe 'XHR GET #new' do
        before { gaku_js_get :new, student_id: student.id }

        it { should respond_with 200 }
        it('assigns @simple_grade') { expect(assigns(:simple_grade)).to be_a_new(Gaku::SimpleGrade) }
        it('assigns @simple_grade_types') { expect(assigns(:simple_grade_types)).to_not be_empty }
        it('renders the :new template') { template? :new }
      end

      describe 'XHR POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create, simple_grade: attributes_for(:simple_grade, simple_grade_type_id: simple_grade_type.id), student_id: student.id
          end

          it 'creates new simple_grade' do
            expect do
              expect do
                valid_js_create
              end.to change(Gaku::SimpleGrade, :count).by(1)
            end.to change(student.simple_grades, :count).by(1)
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
            gaku_js_post :create, simple_grade: attributes_for(:invalid_simple_grade), student_id: student.id
          end

          it 'does not save the new simple_grade' do
            expect do
              invalid_js_create
            end.to_not change(Gaku::SimpleGrade, :count)
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

      describe 'XHR GET #edit' do
        before { gaku_js_get :edit, id: simple_grade, student_id: student.id }

        it { should respond_with 200 }
        it('assigns @simple_grade') { expect(assigns(:simple_grade)).to eq simple_grade }
        it('assigns @simple_grade_types') { expect(assigns(:simple_grade_types)).to_not be_empty }
        it('renders the :edit template') { template? :edit }
      end

      describe 'XHR PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_js_patch :update, id: simple_grade, simple_grade: attributes_for(:simple_grade, score: 145), student_id: student.id
          end

          it { should respond_with 200 }
          it('assigns @simple_grade') { expect(assigns(:simple_grade)).to eq simple_grade }
          it('sets flash') { flash_updated? }
          it "changes simple_grade's attributes" do
            simple_grade.reload
            expect(simple_grade.score).to eq 145
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_js_patch :update, id: simple_grade, simple_grade: attributes_for(:invalid_simple_grade, score: ''), student_id: student.id
          end

          it { should respond_with 200 }
          it('assigns @simple_grade') { expect(assigns(:simple_grade)).to eq simple_grade }

          it "does not change simple_grade's attributes" do
            simple_grade.reload
            expect(simple_grade.score).not_to eq ''
          end
        end
      end

      describe 'XHR DELETE #destroy' do

        let(:js_delete) { gaku_js_delete :destroy, id: simple_grade, student_id: student.id }

        it 'deletes the simple_grade' do
          simple_grade
          expect do
            js_delete
          end.to change(Gaku::SimpleGrade, :count).by(-1)
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
