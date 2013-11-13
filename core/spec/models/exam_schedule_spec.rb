require 'spec_helper_models'

describe Gaku::ExamSchedule do

  describe 'relations' do
    it { should belong_to :exam_portion }
    it { should belong_to :schedule }
    it { should belong_to :course }
  end

  describe 'validations' do
    it { should validate_presence_of :schedule }
    it { should validate_presence_of :exam_portion }
    it { should validate_presence_of :course }
  end

end
