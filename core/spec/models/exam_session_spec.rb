require 'spec_helper_models'

describe Gaku::ExamSession, type: :model do
  it_behaves_like 'enrollable'

  describe 'relations' do
    it { is_expected.to belong_to :exam }
  end

  describe '#to_s' do
    let(:exam_session) { build(:exam_session) }

    specify { exam_session.to_s.should eq exam_session.name }
  end
end
