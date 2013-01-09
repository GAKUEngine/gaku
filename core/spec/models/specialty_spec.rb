require 'spec_helper'

describe Gaku::Specialty do

  context "validations" do
    it { should have_many(:student_specialties) }
    it { should have_many(:students).through(:student_specialties) }

    it { should validate_presence_of :name }
    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :description }
    it { should allow_mass_assignment_of :major_only }
  end
end
