require 'spec_helper_requests'

describe 'Guardians', type: :request do

  let(:guardian_attributes) {
    %i( id name surname middle_name name_reading middle_name_reading surname_reading
      gender birth_date relationship picture_file_name picture_content_type picture_file_size
      picture_updated_at primary_address primary_contact addresses_count contacts_count user_id
      created_at updated_at
    )
  }

  let(:guardian) { create(:guardian) }
  let(:contact) { create(:contact, data: '123321', contactable: guardian) }

  describe 'INDEX' do
    context 'JSON' do
      before do
        guardian
        api_get gaku.api_v1_guardians_path
      end

      it 'success response' do
        ensure_ok
      end

      it 'assign guardians' do
        expect(assigns['guardians']).to include(guardian)
      end

      it 'json attributes' do
        expect(json['guardians'].first).to include(*guardian_attributes)
      end

      it 'total_count' do
        expect(json['meta']).to include({total_count: 1})
      end
      it 'count' do
        expect(json['meta']).to include({count: 1})
      end
      it 'page' do
        expect(json['meta']).to include({page: 1})
      end
    end

    context 'MSGPACK' do
      before do
        guardian
        msgpack_api_get gaku.api_v1_guardians_path
      end

      it 'success response' do
        ensure_ok
      end

      it 'assign guardians' do
        expect(assigns['guardians']).to include(guardian)
      end

      it 'json attributes' do
        expect(msgpack['guardians'].first).to include(*guardian_attributes)
      end
      it 'total_count' do
        expect(msgpack['meta']).to include({total_count: 1})
      end
      it 'count' do
        expect(msgpack['meta']).to include({count: 1})
      end
      it 'page' do
        expect(msgpack['meta']).to include({page: 1})
      end
    end

  end

  describe 'SHOW' do
    context 'JSON' do
      describe 'success' do
        before do
          guardian
          api_get gaku.api_v1_guardian_path(guardian)
        end

        it 'success response' do
          ensure_ok
        end

        it 'assigns guardian' do
          expect(assigns['guardian']).to eq guardian
        end

        it 'json attributes' do
          expect(json).to include(*guardian_attributes)
        end
      end
      describe 'error' do
        before do
          api_get gaku.api_v1_guardian_path(id: 2000)
        end

        it 'render error' do
          expect(json).to eq({'error' => 'record not found'})
        end

        it 'response code' do
          ensure_not_found
        end
      end
    end

    context 'MSGPACK' do
      describe 'success' do
        before do
          guardian
          msgpack_api_get gaku.api_v1_guardian_path(guardian)
        end

        it 'success response' do
          ensure_ok
        end

        it 'assigns guardian' do
          expect(assigns['guardian']).to eq guardian
        end

        it 'json attributes' do
          expect(msgpack).to include(*guardian_attributes)
        end
      end

      describe 'error' do
        before do
          msgpack_api_get gaku.api_v1_guardian_path(id: 2000)
        end

        it 'render error' do
          expect(msgpack).to eq({'error' => 'record not found'})
        end

        it 'response code' do
          ensure_not_found
        end
      end
    end
  end

  describe 'CREATE' do
    context 'JSON' do
      describe 'success' do
        before do
          contact
          expect do
            guardian_params = {name: 'Mickey', surname: 'Mouse', contact: '123321'}
            api_post gaku.api_v1_guardians_path, params: guardian_params
          end.to change(Gaku::Guardian, :count).by(1)
        end

        it 'success response' do
          ensure_ok
        end

        it 'correct guardian attributes' do
          expect(json).to include(name: 'Mickey', surname: 'Mouse')
        end

        it 'json attributes' do
          expect(json).to include(*guardian_attributes)
        end
      end
      describe 'error' do

        before do
          api_post gaku.api_v1_guardians_path, params: {name: 'Mickey'}
        end

        it 'render error' do
          expect(json['error']).to include("Surname can't be blank")
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
            guardian_params = {name: 'Mickey', surname: 'Mouse', birth_date: Date.today}
            msgpack_api_post gaku.api_v1_guardians_path, msgpack: guardian_params
          end.to change(Gaku::Guardian, :count).by(1)
        end

        it 'success response' do
          ensure_ok
        end

        it 'correct guardian attributes' do
          expect(msgpack).to include(name: 'Mickey', surname: 'Mouse')
        end

        it 'msgpack attributes' do
          expect(msgpack).to include(*guardian_attributes)
        end
      end
      describe 'error' do

        before do
          msgpack_api_post gaku.api_v1_guardians_path, msgpack: {name: 'Mickey'}
        end

        it 'render error' do
          expect(msgpack['error']).to include("Surname can't be blank")
        end

        it 'response code' do
          ensure_unprocessable_entity
        end
      end
    end

  end
end
