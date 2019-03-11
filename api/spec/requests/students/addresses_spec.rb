require 'spec_helper_requests'

describe 'Student addresses', type: :request do

  let(:address_attributes) {
    %w[id address1 address2 city zipcode title country_id state_id]
  }

  let(:student) { create(:student) }
  let(:country) { create(:country) }

  describe 'CREATE' do
    context 'JSON' do
      describe 'success' do
        before do
          expect do
            address_params = { address1: 'Syedinenie', country_id: country.id, city: 'Plovdiv'}
            api_post gaku.api_v1_student_addresses_path(student), params: address_params
          end.to change(Gaku::Address, :count).by(1)
        end

        it 'success response' do
          ensure_ok
        end

        it 'correct student attributes' do
          expect(json).to include(address1: 'Syedinenie')
        end

        it 'json attributes' do
          expect(json).to include(*address_attributes)
        end
      end

      describe 'error' do

        before do
            api_post gaku.api_v1_student_addresses_path(student), params: {}
        end

        it 'render error' do
          expect(json).to eq({'error' => ["Address1 can't be blank", "Country can't be blank", "City can't be blank"]})
        end

        it 'response code' do
          ensure_unprocessable_entity
        end
      end
    end

    context 'MSGPACK' do
      describe 'success' do
        before do
          expect do
            address_params = { address1: 'Syedinenie', country_id: country.id, city: 'Plovdiv'}
            msgpack_api_post gaku.api_v1_student_addresses_path(student), msgpack: address_params
          end.to change(Gaku::Address, :count).by(1)
        end

        it 'success response' do
          ensure_ok
        end

        it 'correct student attributes' do
          expect(msgpack).to include(address1: 'Syedinenie')
        end

        it 'msgpack attributes' do
          expect(msgpack).to include(*address_attributes)
        end
      end
      describe 'error' do

        before do
          msgpack_api_post gaku.api_v1_student_addresses_path(student), msgpack: {}
        end

        it 'render error' do
          expect(msgpack).to eq({'error' => ["Address1 can't be blank", "Country can't be blank", "City can't be blank"]})
        end

        it 'response code' do
          ensure_unprocessable_entity
        end
      end
    end
  end
end
