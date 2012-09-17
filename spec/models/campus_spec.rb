require 'spec_helper'

describe Campus do
	context "validations" do
		it { should belong_to (:school) }
	end
end