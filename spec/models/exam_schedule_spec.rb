# == Schema Information
#
# Table name: exam_schedules
#
#  id              :integer          not null, primary key
#  exam_portion_id :integer
#  schedule_id     :integer
#  course_id       :integer
#

require 'spec_helper'

describe ExamSchedule do

  context "validations" do 
  	it { should have_valid_factory(:exam_schedule) }
    it { should belong_to(:exam_portion) }
    it { should belong_to(:schedule) }
    it { should belong_to(:course) }
  end
  
end
