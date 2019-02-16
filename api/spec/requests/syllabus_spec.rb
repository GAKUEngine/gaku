require 'spec_helper_requests'

describe 'Syllabus', type: :request do
  let(:syllabus_attributes) {
    %i( id name code description credits hours created_at updated_at )
  }

  let(:syllabus) { create(:syllabus) }

  describe 'INDEX' do
    context 'JSON' do
      before do
        syllabus
        api_get gaku.api_v1_syllabuses_path
      end

      it 'success response' do
        ensure_ok
      end

      it 'assign syllabuses' do
        expect(assigns['syllabuses']).to include(syllabus)
      end

      it 'json attributes' do
        expect(json['syllabuses'].first).to include(*syllabus_attributes)
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
  end

  context 'MSGPACK' do
    before do
      syllabus
      msgpack_api_get gaku.api_v1_syllabuses_path
    end

    it 'success response' do
      ensure_ok
    end

    it 'assign syllabuses' do
      expect(assigns['syllabuses']).to include(syllabus)
    end

    it 'json attributes' do
      expect(msgpack['syllabuses'].first).to include(*syllabus_attributes)
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

  describe 'SHOW' do
    context 'JSON' do
      describe 'success' do
        before do
          syllabus
          api_get gaku.api_v1_syllabus_path(syllabus)
        end

        it 'success response' do
          ensure_ok
        end

        it 'assigns syllabus' do
          expect(assigns['syllabus']).to eq syllabus
        end

        it 'json attributes' do
          expect(json).to include(*syllabus_attributes)
        end
      end

      describe 'error' do
        before do
          api_get gaku.api_v1_syllabus_path(id: 2000)
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
          syllabus
          msgpack_api_get gaku.api_v1_syllabus_path(syllabus)
        end

        it 'success response' do
          ensure_ok
        end

        it 'assigns syllabus' do
          expect(assigns['syllabus']).to eq syllabus
        end

        it 'json attributes' do
          expect(msgpack).to include(*syllabus_attributes)
        end
      end

      describe 'error' do
        before do
          msgpack_api_get gaku.api_v1_syllabus_path(id: 2000)
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
          expect do
            syllabus_params = { name: 'Mickey', code: 'Mouse' }
            api_post gaku.api_v1_syllabuses_path, params: syllabus_params
          end.to change(Gaku::Syllabus, :count).by(1)
        end

        it 'success response' do
          ensure_ok
        end

        it 'correct syllabus attributes' do
          expect(json).to include(name: 'Mickey', code: 'Mouse')
        end

        it 'json attributes' do
          expect(json).to include(*syllabus_attributes)
        end
      end

      describe 'error' do
        before do
          api_post gaku.api_v1_syllabuses_path, params: { name: 'Mickey' }
        end

        it 'render error' do
          expect(json['error']).to include("Code can't be blank")
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
            syllabus_params = { name: 'Mickey', code: 'Mouse' }
            msgpack_api_post gaku.api_v1_syllabuses_path, msgpack: syllabus_params
          end.to change(Gaku::Syllabus, :count).by(1)
        end

        it 'success response' do
          ensure_ok
        end

        it 'correct syllabus attributes' do
          expect(msgpack).to include(name: 'Mickey', code: 'Mouse')
        end

        it 'msgpack attributes' do
          expect(msgpack).to include(*syllabus_attributes)
        end
      end

      describe 'error' do
        before do
          msgpack_api_post gaku.api_v1_syllabuses_path, msgpack: { name: 'Mickey' }
        end

        it 'render error' do
          expect(msgpack['error']).to include("Code can't be blank")
        end

        it 'response code' do
          ensure_unprocessable_entity
        end
      end
    end
  end

  describe 'UPDATE' do
    context 'JSON' do
      describe 'success' do
        before do
          syllabus = create(:syllabus)
          syllabus_params = { name: 'Mini', code: 'Mouse' }
          api_patch gaku.api_v1_syllabus_path(syllabus), params: syllabus_params
        end

        it 'success response' do
          ensure_ok
        end

        it 'correct syllabus attributes' do
          expect(json).to include(name: 'Mini', code: 'Mouse')
        end

        it 'json attributes' do
          expect(json).to include(*syllabus_attributes)
        end
      end

      describe 'error' do
        before do
          syllabus = create(:syllabus)
          syllabus_params = {name: ''}
          api_patch gaku.api_v1_syllabus_path(syllabus), params: syllabus_params
        end

        it 'render error' do
          expect(json['error']).to include("Name can't be blank")
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
            syllabus_params = { name: 'Mini', code: 'Mouse' }
            msgpack_api_patch gaku.api_v1_syllabus_path(syllabus), msgpack: syllabus_params
          end.to change(Gaku::Syllabus, :count).by(1)
        end

        it 'success response' do
          ensure_ok
        end

        it 'correct syllabus attributes' do
          expect(msgpack).to include(name: 'Mini', code: 'Mouse')
        end

        it 'msgpack attributes' do
          expect(msgpack).to include(*syllabus_attributes)
        end
      end

      describe 'error' do
        before do
          msgpack_api_patch gaku.api_v1_syllabus_path(syllabus), msgpack:  { name: '' }
        end

        it 'render error' do
          expect(msgpack['error']).to include("Name can't be blank")
        end

        it 'response code' do
          ensure_unprocessable_entity
        end
      end
    end
  end

  describe 'DESTROY' do
    context 'JSON' do
      describe 'success' do
        before do
          syllabus
          expect {
            api_delete gaku.api_v1_syllabus_path(syllabus)
          }.to change(Gaku::Syllabus, :count).by(-1)
        end

        it 'success response' do
          ensure_ok
        end

        it 'assigns syllabus' do
          expect(assigns['syllabus']).to eq syllabus
        end

        it 'json attributes' do
          expect(json).to include(*syllabus_attributes)
        end
      end

      describe 'error' do
        before do
          api_delete gaku.api_v1_syllabus_path(id: 2000)
        end

        it 'render error' do
          expect(json).to eq({ 'error' => 'record not found' })
        end

        it 'response code' do
          ensure_not_found
        end
      end
    end

    context 'MSGPACK' do
      describe 'success' do
        before do
          syllabus
          msgpack_api_delete gaku.api_v1_syllabus_path(syllabus)
        end

        it 'success response' do
          ensure_ok
        end

        it 'assigns syllabus' do
          expect(assigns['syllabus']).to eq syllabus
        end

        it 'json attributes' do
          expect(msgpack).to include(*syllabus_attributes)
        end
      end

      describe 'error' do
        before do
          msgpack_api_delete gaku.api_v1_syllabus_path(id: 2000)
        end

        it 'render error' do
          expect(msgpack).to eq({ 'error' => 'record not found' })
        end

        it 'response code' do
          ensure_not_found
        end
      end
    end
  end
end
