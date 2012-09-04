require 'spec_helper'

describe Asset do
	context "validations" do
		it { should belong_to (:exam_portion) }
	end
end