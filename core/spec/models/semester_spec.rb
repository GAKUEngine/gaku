require 'spec_helper'

describe Gaku::Semester do

  context "validations" do
    it { should have_many :semester_courses }
    it { should have_many(:courses).through(:semester_courses) }

    it { should have_many :semester_class_groups }
    it { should have_many(:class_groups).through(:semester_class_groups) }

    it { should allow_mass_assignment_of :starting }
    it { should allow_mass_assignment_of :ending }

    it { should validate_presence_of :starting }
    it { should validate_presence_of :ending }

    xit 'uniqness of class group for semester'
    xit 'ending date is after starting'
  end

end
