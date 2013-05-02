require 'spec_helper'

describe Gaku::GradingMethod do

  context "validations" do
  	it { should have_one(:exam) }
  	it { should have_one(:exam_portion) }
  	it { should have_one(:assignment) }
    it { should have_many(:grading_method_set_items) }
    it { should have_many(:grading_method_sets).through(:grading_method_set_items) }

    it { should allow_mass_assignment_of :description }
    it { should allow_mass_assignment_of :method }
    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :curved }
    it { should allow_mass_assignment_of :arguments }
  end

end
