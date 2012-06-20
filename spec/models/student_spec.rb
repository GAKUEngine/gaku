require 'spec_helper'

describe Student do

  context "validations" do 
  	it { should have_valid_factory(:student) }
    it { should have_many(:course_enrollments) }
    it { should have_many(:courses) }
    it { should have_many(:exams) }
    it { should have_many(:exam_scores) }
    it { should belong_to(:user) }
    it { should belong_to(:profile) }
    it { should have_many :class_group_enrollments }
    it { should have_many(:class_groups) } 
    it { should have_and_belong_to_many(:addresses) } 
    it { should have_and_belong_to_many(:guardians) }
    it { should have_many(:contacts) }
    it { should have_many(:notes) }
  end
  
end