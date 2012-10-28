require 'spec_helper'

describe Campus do
	context "validations" do
		it { should have_valid_factory(:campus) }
		it { should belong_to(:school) }
		it { should have_many(:contacts) }
		it { should belong_to(:address) }

		it { should allow_mass_assignment_of :name }
		it { should allow_mass_assignment_of :school_id }
		it { should allow_mass_assignment_of :address_id }
	end
end