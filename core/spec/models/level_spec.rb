require 'spec_helper_models'

describe Gaku::Level do

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :school }
  end

  describe 'relations' do
    it { should have_many :program_levels }
    it { should have_many(:programs).through(:program_levels) }
    it { should belong_to :school }
  end

  describe '#to_s' do
    let(:level) { build(:level) }
    specify { level.to_s.should eq level.name }
  end

end
