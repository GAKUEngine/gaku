require 'spec_helper_models'

describe Gaku::GradingMethods::Percentage do

  let(:students) { [create(:student), create(:student)] }

  describe 'initialize' do
    xit 'initializes with exam' do
      exam =  create(:exam, :with_portion)
      subject = described_class.new(exam, students)
      expect(subject.grade).to eq ''
    end
  end

end
