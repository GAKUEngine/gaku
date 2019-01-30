require 'spec_helper_models'

describe Gaku::SemesterAttendance, type: :model do
  describe 'relations' do
    it { is_expected.to belong_to :semester }
    it { is_expected.to belong_to :student }
  end

  # describe 'validations' do
  #   it { should validate_presence_of :student }
  #   it { should validate_presence_of :attendance_type }
  # end
end
