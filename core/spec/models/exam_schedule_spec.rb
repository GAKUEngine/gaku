require 'spec_helper_models'

describe Gaku::ExamSchedule, type: :model do

  describe 'relations' do
    it { is_expected.to belong_to :exam_portion }
    it { is_expected.to belong_to :schedule }
    it { is_expected.to belong_to :course }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :schedule }
    it { is_expected.to validate_presence_of :exam_portion }
    it { is_expected.to validate_presence_of :course }
  end

end
