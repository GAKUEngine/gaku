require 'spec_helper_models'

describe Gaku::ExamScore, type: :model do
  describe 'relations' do
    it { is_expected.to belong_to :exam }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :exam }
    it { is_expected.to validate_presence_of :score }
    it { is_expected.to validate_numericality_of :score }
  end
end
