require 'spec_helper'

describe Gaku::ExtracurricularActivity do
  context "validations" do
    it { should have_many :extracurricular_activity_enrollments }
    it { should have_many(:students).through(:extracurricular_activity_enrollments) }

    it { should validate_presence_of :name }

    it { should allow_mass_assignment_of :name }
  end
end
