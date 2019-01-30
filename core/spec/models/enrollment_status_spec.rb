require 'spec_helper_models'

describe Gaku::EnrollmentStatus, type: :model do
  describe 'associations' do
    it { is_expected.to have_many :students }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :code }
    it { is_expected.to validate_uniqueness_of :code }
  end

  describe '#to_s' do
    let(:enrollment_status) { build(:enrollment_status) }

    specify { enrollment_status.to_s.should eq enrollment_status.name }
  end

  describe 'it sets name if missing' do
    let(:enrollment_status) { create(:enrollment_status, name: nil) }

    specify { enrollment_status.name.should eq enrollment_status.code }
  end
end
