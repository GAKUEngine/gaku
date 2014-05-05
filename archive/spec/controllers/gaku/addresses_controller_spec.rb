require 'spec_helper_controllers'

describe Gaku::AddressesController do

  let(:address) { create(:address, addressable: student, country: country) }
  let(:deleted_address) { create(:address, addressable: student, country: country, deleted: true) }
  let!(:student) { create(:student) }
  let!(:country) { create(:country, name: 'USA', iso: 'US') }

  context 'as admin', type: :address do
    before { as :admin }

    context 'student' do

      describe 'XHR DELETE #destroy' do

        let(:js_delete) { gaku_js_delete :destroy, id: address.id, student_id: student.id }

        it 'deletes the address' do
          address
          expect do
            js_delete
          end.to change(Gaku::Address, :count).by(-1)
        end

        it('assigns @polymorphic_resource_name') do
          js_delete
          expect(assigns(:polymorphic_resource_name)).to eq 'student-address'
        end

        it('assigns @polymorphic_resource') do
          js_delete
          expect(assigns(:polymorphic_resource)).to eq student
        end

        it('assigns @nested_resources') do
          js_delete
          expect(assigns(:nested_resources)).to eq []
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
        let(:js_get_soft_delete) { gaku_js_patch :soft_delete, id: address.id, student_id: student.id }

        it 'responds with success' do
          js_get_soft_delete
          should respond_with(200)
        end

        it 'assigns  @address' do
          js_get_soft_delete
          expect(assigns(:address)).to eq address
        end

        it('assigns @polymorphic_resource_name') do
          js_get_soft_delete
          expect(assigns(:polymorphic_resource_name)).to eq 'student-address'
        end

        it('assigns @polymorphic_resource') do
          js_get_soft_delete
          expect(assigns(:polymorphic_resource)).to eq student
        end

        it('assigns @nested_resources') do
          js_get_soft_delete
          expect(assigns(:nested_resources)).to eq []
        end

        it 'updates :deleted attribute' do
          expect do
            js_get_soft_delete
            address.reload
          end.to change(address, :deleted)
        end

        it 'sets flash' do
          js_get_soft_delete
          flash_destroyed?
        end
      end

      describe 'XHR PATCH #recovery' do
        let(:js_get_recovery) { gaku_js_patch :recovery, id: deleted_address.id, student_id: student.id }

        it 'responds with success' do
          js_get_recovery
          should respond_with(200)
        end

        it 'assigns  @address' do
          js_get_recovery
          expect(assigns(:address)).to eq deleted_address
        end

        it('assigns @polymorphic_resource_name') do
          js_get_recovery
          expect(assigns(:polymorphic_resource_name)).to eq 'student-address'
        end

        it('assigns @polymorphic_resource') do
          js_get_recovery
          expect(assigns(:polymorphic_resource)).to eq student
        end

        it('assigns @nested_resources') do
          js_get_recovery
          expect(assigns(:nested_resources)).to eq []
        end

        it 'renders :recovery' do
          js_get_recovery
          should render_template :recovery
        end

        it 'sets flash' do
          js_get_recovery
          flash_recovered?
        end

        it 'updates :deleted attribute' do
          expect do
            js_get_recovery
            deleted_address.reload
          end.to change(deleted_address, :deleted)
        end
      end

    end

  end
end
