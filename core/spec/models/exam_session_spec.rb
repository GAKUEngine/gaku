require 'spec_helper_models'

describe Gaku::ExamSession do

  # describe 'validations' do
  # end

  describe 'relations' do
    it { should belong_to :exam }
    it { should have_many(:student_exam_sessions) }
    it { should have_many(:students).through(:student_exam_sessions) }

  end

  describe '#to_s' do
    let(:exam_session) { build(:exam_session) }
    specify { exam_session.to_s.should eq exam_session.name }
  end

end
