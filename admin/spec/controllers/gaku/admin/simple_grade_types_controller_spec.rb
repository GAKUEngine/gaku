require 'spec_helper_controllers'

describe Gaku::Admin::SimpleGradeTypesController do

  let(:simple_grade_type) { create(:simple_grade_type) }
  let(:invalid_simple_grade_type) do
    create(:invalid_simple_grade_type, school: school, grading_method: grading_method)
  end
  let(:school) { create(:school) }
  let(:grading_method) { create(:grading_method) }

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
          simple_grade_type
          gaku_js_get :index
        end

        it { should respond_with 200 }
        it('assigns @simple_grade_types') { expect(assigns(:simple_grade_types)).to eq [simple_grade_type] }
        it('assigns @count') { expect(assigns(:count)).to eq 1 }
        it('renders :index template') { template? :index }
      end

      describe 'XHR #new' do
        before do
          school; grading_method
          gaku_js_get :new
        end

        it { should respond_with 200 }
        it('assigns @simple_grade_type') { expect(assigns(:simple_grade_type)).to be_a_new(Gaku::SimpleGradeType) }
        it('renders the :new template') { template? :new }
        it('assigns @schools') { expect(assigns(:schools)).to eq [school] }
        it('assigns @grading_methods') { expect(assigns(:grading_methods)).to eq [grading_method] }

      end

      describe 'POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create, simple_grade_type: attributes_for(:simple_grade_type)
          end

          it 'creates new simple_grade_type' do
            expect do
              valid_js_create
            end.to change(Gaku::SimpleGradeType, :count).by(1)
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
            gaku_js_post :create, simple_grade_type: attributes_for(:invalid_simple_grade_type)
          end

          it 'does not save the new simple_grade_type' do
            expect do
              invalid_js_create
            end.to_not change(Gaku::SimpleGradeType, :count)
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
          gaku_js_get :edit, id: simple_grade_type
        end

        it { should respond_with 200 }
        it('assigns @simple_grade_type') { expect(assigns(:simple_grade_type)).to eq simple_grade_type }
        it('renders the :edit template') { template? :edit }
        it('assigns @schools') { expect(assigns(:schools)).to eq [simple_grade_type.school] }
        it('assigns @grading_methods') { expect(assigns(:grading_methods)).to eq [simple_grade_type.grading_method] }
      end

      describe 'PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_js_patch :update, id: simple_grade_type, simple_grade_type: attributes_for(:simple_grade_type, name: 'Ruby dev')
          end

          it { should respond_with 200 }
          it('assigns @simple_grade_type') { expect(assigns(:simple_grade_type)).to eq simple_grade_type }
          it('sets flash') { flash_updated? }
          it "changes simple_grade_type's attributes" do
            simple_grade_type.reload
            expect(simple_grade_type.name).to eq 'Ruby dev'
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_js_patch :update, id: simple_grade_type, simple_grade_type: attributes_for(:invalid_simple_grade_type, name: '')
          end

          it { should respond_with 200 }
          it('assigns @simple_grade_type') { expect(assigns(:simple_grade_type)).to eq simple_grade_type }

          it "does not change simple_grade_type's attributes" do
            simple_grade_type.reload
            expect(simple_grade_type.name).not_to eq ''
          end
        end
      end

      describe 'XHR DELETE #destroy' do
        it 'deletes the simple_grade_type' do
          simple_grade_type
          expect do
            gaku_js_delete :destroy, id: simple_grade_type
          end.to change(Gaku::SimpleGradeType, :count).by(-1)
        end

        it 'decrements @count' do
          gaku_js_delete :destroy, id: simple_grade_type
          expect(assigns(:count)).to eq 0
        end

        it 'sets flash' do
          gaku_js_delete :destroy, id: simple_grade_type
          flash_destroyed?
        end
      end

    end

  end
end
