require 'spec_helper'

describe Gaku::AddressesController do

  let(:address) { create(:address, addressable: student, country: country) }
  let(:invalid_address) { create(:invalid_address, addressable: student) }
  let!(:student) { create(:student) }
  let!(:country) { create(:country, name: 'USA', iso: 'US') }

  context 'as admin' do
    before { as :admin }

    context 'js' do

      describe 'XHR #new' do
        before { gaku_js_get :new, student_id: student.id }

        it { should respond_with 200 }
        it('assigns @address') { expect(assigns(:address)).to be_a_new(Gaku::Address) }
        it('renders the :new template') { template? :new }
      end

      describe 'XHR POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create, address: attributes_for(:address, country_id: country.id), student_id: student.id
          end

          it 'creates new address' do
            expect do
              expect do
                valid_js_create
              end.to change(Gaku::Address, :count).by(1)
            end.to change(student.addresses, :count).by(1)
          end

          it 'renders flash' do
            valid_js_create
            flash_created?
          end

          it 'sets @polymorphic_resource' do
            valid_js_create
            expect(assigns(:polymorphic_resource)).to eq student
          end

          it 'sets @polymorphic_resource_name' do
            valid_js_create
            expect(assigns(:polymorphic_resource_name)).to eq 'student-address'
          end

          it 'sets @nested_resources' do
            valid_js_create
            expect(assigns(:nested_resources)).to eq []
          end

          it 'increments @count' do
            valid_js_create
            expect(assigns(:count)).to eq 1
          end
        end

        context 'with invalid attributes' do
          let(:invalid_js_create) do
            gaku_js_post :create, address: attributes_for(:invalid_address, country_id: country.id), student_id: student.id
          end

          it 'does not save the new address' do
            expect do
              invalid_js_create
            end.to_not change(Gaku::Address, :count)
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
        before { gaku_js_get :edit, id: address.id, student_id: student.id }

        it { should respond_with 200 }
        it('assigns @address') { expect(assigns(:address)).to eq address }
        it('renders the :edit template') { template? :edit }
      end

      describe 'PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_js_patch :update, id: address.id, student_id: student.id, address: attributes_for(:address, address1: 'mobifon')
          end

          it { should respond_with 200 }
          it('assigns @address') { expect(assigns(:address)).to eq address }
          it('sets flash') { flash_updated? }
          it "changes address's attributes" do
            expect(address.reload.address1).to eq 'mobifon'
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_js_patch :update, id: address.id, student_id: student.id, address: attributes_for(:invalid_address, address1: '')
          end

          it { should respond_with 200 }
          it('assigns @address') { expect(assigns(:address)).to eq address }

          it "does not change address's attributes" do
            expect(address.reload.address1).not_to eq ''
          end
        end
      end

      describe 'XHR DELETE #destroy' do

        let(:js_delete) { gaku_js_delete :destroy, id: address.id, student_id: student.id }

        it 'deletes the address' do
          address
          expect do
            js_delete
          end.to change(Gaku::Address, :count).by(-1)
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


      describe 'XHR PATCH #soft_delete' do
        let(:get_soft_delete) { gaku_js_patch :soft_delete, id: address.id, student_id: student.id }

        it 'redirects' do
          get_soft_delete
          should respond_with(200)
        end

        it 'assigns  @address' do
          get_soft_delete
          expect(assigns(:address)).to eq address
        end

        it 'updates :deleted attribute' do
          expect do
            get_soft_delete
            address.reload
          end.to change(address, :deleted)
        end
      end

      describe 'XHR PATCH #recovery' do
        let(:get_recovery) { gaku_js_patch :recovery, id: address.id, student_id: student.id }

        it 'is successfull' do
          get_recovery
          should respond_with(200)
        end

        it 'assigns  @address' do
          get_recovery
          expect(assigns(:address)).to eq address
        end

        it 'renders :recovery' do
          get_recovery
          should render_template :recovery
       end

        it 'updates :deleted attribute' do
          address.soft_delete
          expect do
            get_recovery
            address.reload
          end.to change(address, :deleted)
        end
      end

    end
  end

end
