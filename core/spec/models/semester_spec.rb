require 'spec_helper'

describe Gaku::Semester do
  let(:school_year) {school_year =  create(:school_year, :starting => Date.parse('2013-3-8'), :ending => Date.parse('2014-11-8'))}

  context "validations" do
    it { should have_many :semester_courses }
    it { should have_many(:courses).through(:semester_courses) }

    it { should have_many :semester_class_groups }
    it { should have_many(:class_groups).through(:semester_class_groups) }

    it { should belong_to :school_year}

    it { should allow_mass_assignment_of :starting }
    it { should allow_mass_assignment_of :ending }

    it { should validate_presence_of :starting }
    it { should validate_presence_of :ending }

    context 'custom validations' do
      before do
      end

      it 'validation error for ending before after' do
        school_year
        semester = school_year.semesters.create :starting => Date.parse('2013-4-8'), :ending => Date.parse('2013-4-7')
        semester.valid?.should be_false
        semester.should have(1).error_on(:ending)
      end

      it "validation error on not between school year starting and ending" do
        school_year
        semester = school_year.semesters.create :starting => Date.parse('2013-3-7'), :ending => Date.parse('2014-11-9')
        semester.valid?.should be_false
        semester.should have(1).error_on(:base)
      end
    end


    xit 'uniqness of class group for semester'
  end

end
