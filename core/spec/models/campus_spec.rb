require 'spec_helper'

describe Gaku::Campus do
	context "validations" do
		it { should belong_to(:school) }
		it { should have_many(:contacts) }
		it { should have_one(:address) }

		it { should allow_mass_assignment_of :name }
		it { should allow_mass_assignment_of :school_id }
		it { should allow_mass_assignment_of :address_id }
	end
end