require 'spec_helper'

describe Asset do
	context "validations" do
		it { should belong_to (:exam_portion) }
		it { should belong_to (:lesson_plan) }
	end
end