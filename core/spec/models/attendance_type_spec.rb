require 'spec_helper_models'

describe Gaku::AttendanceType do

  describe 'relations' do
    it { should have_many :attendances }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end

  describe '#to_s' do
    let(:attendance_type) { build(:attendance_type) }
    specify { attendance_type.to_s.should eq attendance_type.name }
  end

end
