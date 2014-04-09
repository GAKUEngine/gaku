require 'spec_helper_controllers'

describe Gaku::Admin::EnrollmentStatusesController do

  let(:enrollment_status) { create(:enrollment_status) }
  let(:invalid_enrollment_status) { create(:invalid_enrollment_status) }

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

    context 'js' do

       describe 'XHR #index' do
        before do
          enrollment_status
          gaku_js_get :index
        end

        it { should respond_with 200 }
        it('assigns @enrollment_statuses') { expect(assigns(:enrollment_statuses)).to eq [enrollment_status] }
        it('assigns @count') { expect(assigns(:count)).to eq 1 }
        it('renders :index template') { template? :index }
      end

      describe 'XHR #new' do
        before { gaku_js_get :new }

        it { should respond_with 200 }
        it('assigns @enrollment_status') { expect(assigns(:enrollment_status)).to be_a_new(Gaku::EnrollmentStatus) }
        it('renders the :new template') { template? :new }
      end

      describe 'POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create, enrollment_status: attributes_for(:enrollment_status)
          end

          it 'creates new enrollment_status' do
            expect do
              valid_js_create
            end.to change(Gaku::EnrollmentStatus, :count).by(1)
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
            gaku_js_post :create, enrollment_status: attributes_for(:invalid_enrollment_status)
          end

          it 'does not save the new enrollment_status' do
            expect do
              invalid_js_create
            end.to_not change(Gaku::EnrollmentStatus, :count)
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
        before { gaku_js_get :edit, id: enrollment_status }

        it { should respond_with 200 }
        it('assigns @enrollment_status') { expect(assigns(:enrollment_status)).to eq enrollment_status }
        it('renders the :edit template') { template? :edit }
      end

      describe 'PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_js_patch :update, id: enrollment_status, enrollment_status: attributes_for(:enrollment_status, code: 'new status')
          end

          it { should respond_with 200 }
          it('assigns @enrollment_status') { expect(assigns(:enrollment_status)).to eq enrollment_status }
          it('sets flash') { flash_updated? }
          it "changes enrollment_status's attributes" do
            expect(enrollment_status.reload.code).to eq 'new status'
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_js_patch :update, id: enrollment_status, enrollment_status: attributes_for(:invalid_enrollment_status, code: '')
          end

          it { should respond_with 200 }
          it('assigns @enrollment_status') { expect(assigns(:enrollment_status)).to eq enrollment_status }

          it "does not change enrollment_status's attributes" do
            enrollment_status.reload
            expect(enrollment_status.code).not_to eq ''
          end
        end
      end

      describe 'XHR DELETE #destroy' do
        it 'deletes the enrollment_status' do
          enrollment_status
          expect do
            gaku_js_delete :destroy, id: enrollment_status
          end.to change(Gaku::EnrollmentStatus, :count).by(-1)
        end

        it 'decrements @count' do
          gaku_js_delete :destroy, id: enrollment_status
          expect(assigns(:count)).to eq 0
        end

        it 'sets flash' do
          gaku_js_delete :destroy, id: enrollment_status
          flash_destroyed?
        end
      end

    end

  end
end
