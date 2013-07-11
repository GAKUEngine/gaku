require 'spec_helper'

describe Gaku::Attendance do

  describe 'associations' do
  	it { should belong_to :attendance_type }
  	it { should belong_to :attendancable }
    it { should belong_to :student }
  end

end
