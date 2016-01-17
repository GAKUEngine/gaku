require 'spec_helper_models'

describe Gaku::ExamSession do

  it_behaves_like 'enrollmentable'

  describe 'relations' do
    it { should belong_to :exam }
  end

  describe '#to_s' do
    let(:exam_session) { build(:exam_session) }
    specify { exam_session.to_s.should eq exam_session.name }
  end

end
