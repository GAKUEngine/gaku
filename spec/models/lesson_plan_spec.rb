require 'spec_helper'

describe LessonPlan do

  context "validations" do 
  	it { should have_valid_factory(:lesson_plan) }

  	it { should have_many(:lessons) }
  	it { should have_many(:notes) }
  	it { should have_many(:assets) }

  	it { should allow_mass_assignment_of :title }
  	it { should allow_mass_assignment_of :description }
  end
end