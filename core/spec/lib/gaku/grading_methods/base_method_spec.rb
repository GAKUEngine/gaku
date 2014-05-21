require 'spec_helper_models'

describe Gaku::GradingMethods::BaseMethod do

  let(:students) { [create(:student), create(:student)] }

  describe 'initialize' do
    it 'initializes with exam' do
      exam =  create(:exam)
      subject = described_class.new(exam, students)
      expect(subject).to receive(:grade_exam)
      subject.grade
    end
  end

end
