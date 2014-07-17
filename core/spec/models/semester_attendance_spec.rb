require 'spec_helper_models'

describe Gaku::SemesterAttendance do

  describe 'relations' do
    it { should belong_to :semester }
    it { should belong_to :student }
  end

  # describe 'validations' do
  #   it { should validate_presence_of :student }
  #   it { should validate_presence_of :attendance_type }
  # end

end
