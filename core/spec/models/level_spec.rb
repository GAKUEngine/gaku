require 'spec_helper_models'

describe Gaku::Level, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of :name }
    it { is_expected.to validate_presence_of :school }
  end

  describe 'relations' do
    it { is_expected.to have_many :program_levels }
    it { is_expected.to have_many(:programs).through(:program_levels) }
    it { is_expected.to belong_to :school }
  end

  describe '#to_s' do
    let(:level) { build(:level) }

    specify { level.to_s.should eq level.name }
  end
end
