require 'spec_helper_models'

describe Gaku::AttendanceType, type: :model do
  describe 'relations' do
    it { is_expected.to have_many :attendances }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of :name }
  end

  describe '#to_s' do
    let(:attendance_type) { build(:attendance_type) }

    specify { attendance_type.to_s.should eq attendance_type.name }
  end
end
