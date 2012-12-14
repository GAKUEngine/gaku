require 'spec_helper'

describe Gaku::CourseEnrollment do

  context "validations" do
    it { should belong_to(:course) }
    it { should belong_to(:student) }
  end
  
end
