require 'spec_helper'

describe Campus do
	context "validations" do
		it { should belong_to (:school) }
		it { should have_many (:contacts) }
		it { should belong_to (:address) }

	
	end
end