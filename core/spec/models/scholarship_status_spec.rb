require 'spec_helper_models'

describe Gaku::ScholarshipStatus, type: :model do
  describe 'associations' do
    it { is_expected.to have_many :students }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of :name }
  end

  describe '#to_s' do
    let(:scholarship_status) { build(:scholarship_status) }

    specify { scholarship_status.to_s.should eq scholarship_status.name }
  end
end
