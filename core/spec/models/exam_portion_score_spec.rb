require 'spec_helper_models'

describe Gaku::ExamPortionScore, type: :model do
  describe 'relations' do
    it { is_expected.to belong_to :exam_portion }
    it { is_expected.to belong_to :student }
    it { is_expected.to have_many :attendances }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :student }
    it { is_expected.to validate_presence_of :exam_portion }
  end
end
