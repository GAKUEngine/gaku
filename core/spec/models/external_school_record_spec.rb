require 'spec_helper_models'

describe Gaku::ExternalSchoolRecord, type: :model do

  describe 'associations' do
    it { should belong_to :school }
    it { should belong_to :student }
  end

  describe 'validations' do
    it { should validate_presence_of :student }
    it { should validate_presence_of :school }
  end

  describe '#attendance_rate' do
    let(:external_school_record) do
      build(:external_school_record, total_units: 16, units_absent: 13)
    end

    let(:external_school_record2) { build(:external_school_record) }

    it 'return attendance rate if total_units and units_absent are present' do
      expect(external_school_record.attendance_rate).to eq 18.75
    end

    it 'return nil if total_units and units_absent are not present' do
      expect(external_school_record2.attendance_rate).to eq nil
    end

  end

end
