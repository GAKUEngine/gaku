require 'spec_helper_models'

describe Gaku::ExamPortionScore do

  describe 'relations' do
    it { should belong_to :exam_portion }
    it { should belong_to :student }
    it { should have_many :attendances }
  end

  describe 'validations' do
    it { should validate_presence_of :student }
    it { should validate_presence_of :exam_portion }
  end

end
