require 'spec_helper'

describe Student do
  context "validations" do 
    it { should have_many(:course_enrollments) }
    it { should have_many(:courses) }
    it { should have_many(:exams) }
  end
end