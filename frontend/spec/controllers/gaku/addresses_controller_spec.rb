require 'spec_helper_controllers'

describe Gaku::AddressesController, type: :controller do

  let(:address) { create(:address, addressable: student, country: country) }
  let(:invalid_address) { build(:invalid_address, addressable: student) }
  let!(:student) { create(:student) }
  let!(:country) { create(:country, name: 'USA', iso: 'US') }

  context 'as admin', type: :address do
    before { as :admin }

    context 'student' do

      describe 'XHR GET #new' do
        before { gaku_js_get :new, student_id: student.id }

        it { should respond_with 200 }
        it('assigns @address') { expect(assigns(:address)).to be_a_new(Gaku::Address) }
        it('assigns @countries') { expect(assigns(:countries)).to eq [country] }

        it('assigns @polymorphic_resource_name') do
          expect(assigns(:polymorphic_resource_name)).to eq 'student-address'
        end

        it('assigns @polymorphic_resource') { expect(assigns(:polymorphic_resource)).to eq student }
        it('assigns @nested_resources') { expect(assigns(:nested_resources)).to eq [] }
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
            gaku_js_post :create, address: attributes_for(:invalid_address, country_id: country.id),
                                  student_id: student.id
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

      describe 'XHR GET #edit' do
        before { gaku_js_get :edit, id: address.id, student_id: student.id }

        it { should respond_with 200 }
        it('assigns @address') { expect(assigns(:address)).to eq address }
        it('assigns @countries') { expect(assigns(:countries)).to eq [country] }

        it('assigns @polymorphic_resource_name') do
          expect(assigns(:polymorphic_resource_name)).to eq 'student-address'
        end

        it('assigns @polymorphic_resource') { expect(assigns(:polymorphic_resource)).to eq student }
        it('assigns @nested_resources') { expect(assigns(:nested_resources)).to eq [] }
        it('renders the :edit template') { template? :edit }
      end

      describe 'PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_js_patch :update, id: address.id,
                                   student_id: student.id,
                                   address: attributes_for(:address, address1: 'mobifon')
          end

          it { should respond_with 200 }
          it('assigns @address') { expect(assigns(:address)).to eq address }

          it('assigns @polymorphic_resource_name') do
            expect(assigns(:polymorphic_resource_name)).to eq 'student-address'
          end

          it('assigns @polymorphic_resource') { expect(assigns(:polymorphic_resource)).to eq student }
          it('assigns @nested_resources') { expect(assigns(:nested_resources)).to eq [] }
          it('sets flash') { flash_updated? }
          it "changes address's attributes" do
            expect(address.reload.address1).to eq 'mobifon'
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_js_patch :update, id: address.id,
                                   student_id: student.id,
                                   address: attributes_for(:invalid_address, address1: '')
          end

          it { should respond_with 200 }
          it('assigns @address') { expect(assigns(:address)).to eq address }
          it "does not change address's attributes" do
            expect(address.reload.address1).not_to eq ''
          end
        end
      end

    end

  end
end
