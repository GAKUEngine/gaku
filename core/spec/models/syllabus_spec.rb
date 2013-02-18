require 'spec_helper'

describe Gaku::Syllabus do

  context "validations" do

    it_behaves_like 'notable'

    it { should have_many :courses }
    it { should have_many :assignments }
    it { should have_many :lesson_plans }
    it { should have_many :exam_syllabuses }
    it { should have_many(:exams).through(:exam_syllabuses) }
    it { should have_many :notes }

    it { should validate_presence_of :name }
    it { should validate_presence_of :code }

    it { should accept_nested_attributes_for :exams }
    it { should accept_nested_attributes_for :assignments }

    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :code }
    it { should allow_mass_assignment_of :description }
    it { should allow_mass_assignment_of :credits }
    it { should allow_mass_assignment_of :exams }
    it { should allow_mass_assignment_of :exams_attributes }
    it { should allow_mass_assignment_of :assignments }
    it { should allow_mass_assignment_of :assignments_attributes }

  end
end
