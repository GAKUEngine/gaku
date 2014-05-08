require 'spec_helper_models'

describe Gaku::Attendance do

  describe 'relations' do
    it { should belong_to :attendance_type }
    it { should belong_to :attendancable }
    it { should belong_to :student }
  end

  describe 'validations' do
    it { should validate_presence_of :student }
    it { should validate_presence_of :attendance_type }
  end

  describe '#to_s' do
    let(:attendance) { build(:attendance) }
    specify { attendance.to_s.should eq attendance.reason }
  end

end
