require 'spec_helper'

describe Gaku::LessonPlan do

  context "validations" do

    it_behaves_like 'notable'

  	it { should have_many(:lessons) }
  	it { should have_many(:attachments) }
  	it { should belong_to(:syllabus) }

  	it { should allow_mass_assignment_of :title }
  	it { should allow_mass_assignment_of :description }
  end
end
