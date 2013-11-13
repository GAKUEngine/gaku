require 'spec_helper_models'

describe Gaku::EnrollmentStatus do

  describe 'associations' do
    it { should have_many :students }
  end

  describe 'validations' do
    it { should validate_presence_of :code }
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
