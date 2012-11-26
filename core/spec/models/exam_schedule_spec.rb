require 'spec_helper'

describe Gaku::ExamSchedule do

  context "validations" do 
  	it { should have_valid_factory(:exam_schedule) }
    it { should belong_to(:exam_portion) }
    it { should belong_to(:schedule) }
    it { should belong_to(:course) }
  end
  
end
