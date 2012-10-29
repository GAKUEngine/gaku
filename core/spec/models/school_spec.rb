require 'spec_helper'

describe School do
	context "validations" do
		it { should have_valid_factory(:school) }
		it { should have_many (:campuses) }

		it { should allow_mass_assignment_of :name }
		it { should allow_mass_assignment_of :is_primary }
		it { should allow_mass_assignment_of :slogan }
		it { should allow_mass_assignment_of :description }
		it { should allow_mass_assignment_of :founded }
		it { should allow_mass_assignment_of :principal }
		it { should allow_mass_assignment_of :vice_principal }
		it { should allow_mass_assignment_of :grades }
	end
end