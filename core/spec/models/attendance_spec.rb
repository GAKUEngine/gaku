require 'spec_helper_models'

describe Gaku::Attendance, type: :model do
  describe 'relations' do
    it { is_expected.to belong_to :attendance_type }
    it { is_expected.to belong_to :attendancable }
    it { is_expected.to belong_to :student }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :student }
    it { is_expected.to validate_presence_of :attendance_type }
  end

  describe '#to_s' do
    let(:attendance) { build(:attendance) }

    specify { attendance.to_s.should eq attendance.reason }
  end
end
