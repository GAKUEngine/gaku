require 'spec_helper_models'

describe Gaku::ExamScore, type: :model do

  describe 'relations' do
    it { should belong_to :exam }
  end

  describe 'validations' do
    it { should validate_presence_of :exam }
    it { should validate_presence_of :score }
    it { should validate_numericality_of :score }
  end

end
