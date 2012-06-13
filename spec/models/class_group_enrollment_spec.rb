require 'spec_helper'

describe ClassGroupEnrollment do

  context "validations" do 
  	it { should have_valid_factory(:class_group_enrollment) }
    it { should belong_to(:class_group) }
    it { should belong_to(:student) }
  end
  
end