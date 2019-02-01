require 'spec_helper_requests'

describe 'Syllabus', type: :request do
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
    end
  end
end
