require 'spec_helper_models'

describe Gaku::Country, type: :model do
  describe 'associations' do
    it { is_expected.to have_many :states }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :iso_name }
    it { is_expected.to validate_presence_of :iso }
    it { is_expected.to validate_uniqueness_of :iso }
  end

  describe '#to_s' do
    let(:country) { build(:country) }

    specify { country.to_s.should eq country.name }
  end
end
