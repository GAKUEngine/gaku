require 'spec_helper_controllers'

describe Gaku::Admin::AttendanceTypesController do

  let(:attendance_type) { create(:attendance_type) }
  let(:invalid_attendance_type) { create(:invalid_attendance_type) }

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

    context 'json' do

      let(:attributes) do
       %i( name color_code counted_absent disable_credit credit_rate auto_credit created_at updated_at )
      end

      describe 'GET #index' do
        render_views
        before do
          attendance_type
          api_get :index
        end

        it { should respond_with 200 }
        it('renders :index template') { template? :index }
        it 'has attributes' do
          expect(json_response.first).to have_attributes(attributes)
        end
      end

    end

    context 'js' do

      describe 'XHR #index' do
        before do
          attendance_type
          gaku_js_get :index
        end

        it { should respond_with 200 }
        it('assigns @attendance_types') { expect(assigns(:attendance_types)).to eq [attendance_type] }
        it('assigns @count') { expect(assigns(:count)).to eq 1 }
        it('renders :index template') { template? :index }
      end

      describe 'XHR #new' do
        before { gaku_js_get :new }

        it { should respond_with 200 }
        it('assigns @attendance_type') { expect(assigns(:attendance_type)).to be_a_new(Gaku::AttendanceType) }
        it('renders the :new template') { template? :new }
      end

      describe 'POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create, attendance_type: attributes_for(:attendance_type)
          end

          it 'creates new attendance_type' do
            expect do
              valid_js_create
            end.to change(Gaku::AttendanceType, :count).by(1)
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
            gaku_js_post :create, attendance_type: attributes_for(:invalid_attendance_type)
          end

          it 'does not save the new attendance_type' do
            expect do
              invalid_js_create
            end.to_not change(Gaku::AttendanceType, :count)
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
        before { gaku_js_get :edit, id: attendance_type }

        it { should respond_with 200 }
        it('assigns @attendance_type') { expect(assigns(:attendance_type)).to eq attendance_type }
        it('renders the :edit template') { template? :edit }
      end

      describe 'PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_js_patch :update, id: attendance_type, attendance_type: attributes_for(:attendance_type, name: 'new type')
          end

          it { should respond_with 200 }
          it('assigns @attendance_type') { expect(assigns(:attendance_type)).to eq attendance_type }
          it('sets flash') { flash_updated? }
          it "changes attendance_type's attributes" do
            attendance_type.reload
            expect(attendance_type.name).to eq 'new type'
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_js_patch :update, id: attendance_type, attendance_type: attributes_for(:invalid_attendance_type, name: '')
          end

          it { should respond_with 200 }
          it('assigns @attendance_type') { expect(assigns(:attendance_type)).to eq attendance_type }

          it "does not change attendance_type's attributes" do
            attendance_type.reload
            expect(attendance_type.name).not_to eq ''
          end
        end
      end

      describe 'XHR DELETE #destroy' do
        it 'deletes the attendance_type' do
          attendance_type
          expect do
            gaku_js_delete :destroy, id: attendance_type
          end.to change(Gaku::AttendanceType, :count).by(-1)
        end

        it 'decrements @count' do
          gaku_js_delete :destroy, id: attendance_type
          expect(assigns(:count)).to eq 0
        end

        it 'sets flash' do
          gaku_js_delete :destroy, id: attendance_type
          flash_destroyed?
        end
      end

    end

  end
end
