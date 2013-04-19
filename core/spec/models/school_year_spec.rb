require 'spec_helper'

module Gaku
  describe SchoolYear do
    context "validations" do
      it { should validate_presence_of :starting }
      it { should validate_presence_of :ending }
      it { should allow_mass_assignment_of :starting }
      it { should allow_mass_assignment_of :ending }

      it { should have_many :semesters}

      it 'validation error for ending before after' do
        school_year = Gaku::SchoolYear.create :starting => Date.parse('2013-4-8'), :ending => Date.parse('2013-4-7')
        school_year.valid?.should be_false
        school_year.should have(1).error_on(:ending)
      end

    end

  end
end
