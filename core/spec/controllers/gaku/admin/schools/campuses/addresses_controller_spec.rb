require 'spec_helper'

describe Gaku::Admin::Schools::Campuses::AddressesController do

  let!(:country) { create(:country, name: 'USA', iso: 'US') }
  let!(:school) { create(:school) }
  let!(:campus) { school.master_campus }
  let(:address) { create(:address, country: country) }

  context 'as admin' do
    before { as :admin }

    context 'js' do

      describe 'JS GET #edit' do
        before do
          school.master_campus.address =  address
          gaku_js_get :edit, id: address, school_id: school.id, campus_id: campus.id
        end

        it { should respond_with 200 }
        it('assigns @address') { expect(assigns(:address)).to eq address }
        it('renders the :edit template') { template? :edit }
      end


      describe 'JS PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_js_patch :update, id: address, school_id: school.id, campus_id: campus.id, address: attributes_for(:address, address1: 'test')
          end

          it { should respond_with 200 }
          it('renders :update template') { template? :update }
          it('assigns @address') { expect(assigns(:address)).to eq address }
          it('sets flash') { flash_updated? }
          it "changes address's attributes" do
            address.reload
            expect(address.address1).to eq 'test'
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_js_patch :update, id: address, school_id: school.id, campus_id: campus.id, address: attributes_for(:address, address1: '')
          end

          it { should respond_with 200 }
          it('assigns @address') { expect(assigns(:address)).to eq address }

          it "does not change address's attributes" do
            address.reload
            expect(address.address1).not_to eq ''
          end
        end
      end

      describe 'JS #new' do
        before { gaku_js_get :new, school_id: school.id, campus_id: campus.id }

        it { should respond_with 200 }
        it('assigns @address') { expect(assigns(:address)).to be_a_new(Gaku::Address) }
        it('renders the :new template') { template? :new }
      end

      describe 'JS POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create, school_id: school.id, campus_id: campus.id, address: attributes_for(:address, country_id: country.id)
          end

          it 'creates new address' do
            expect do
              valid_js_create
            end.to change(Gaku::Address, :count).by(1)
          end

          it 'renders flash' do
            valid_js_create
            flash_created?
          end

        end

        context 'with invalid attributes' do
          let(:invalid_js_create) do
            gaku_js_post :create, school_id: school.id, campus_id: campus.id,  address: attributes_for(:invalid_address, address1: nil)
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
        end
      end

      describe 'JS DELETE #destroy' do
        it 'deletes the address' do
          school.master_campus.address =  address
          expect do
            gaku_js_delete :destroy, id: address, school_id: school.id, campus_id: campus.id
          end.to change(Gaku::Address, :count).by(-1)
        end

        it 'sets flash' do
          school.master_campus.address =  address
          gaku_js_delete :destroy, id: address, school_id: school.id, campus_id: campus.id
          flash_destroyed?
        end
      end

    end
  end

end
