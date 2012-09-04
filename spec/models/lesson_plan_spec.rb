require 'spec_helper'

describe LessonPlan do

  context "validations" do 
  	it { should have_valid_factory(:lesson_plan) }

  	it { should allow_mass_assignment_of :title }
  	it { should allow_mass_assignment_of :description }
  end
end