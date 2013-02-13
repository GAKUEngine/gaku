require 'spec_helper'

describe Gaku::Campus do
	context "validations" do

    it_behaves_like 'contactable'

		it { should belong_to(:school) }
		it { should have_one(:address) }

    it { should validate_presence_of(:name) }

		it { should allow_mass_assignment_of :name }
		it { should allow_mass_assignment_of :school_id }
	end
end
