require 'spec_helper'

module Gaku
  describe SchoolYear do
    context "validations" do
      it { should validate_presence_of :starting }
      it { should validate_presence_of :ending }
      it { should allow_mass_assignment_of :starting }
      it { should allow_mass_assignment_of :ending }

      it { should have_many :semesters}

    end

  end
end
