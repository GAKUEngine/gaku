require 'spec_helper'

describe School do
	context "validations" do
		it { should have_many (:campuses) }
	end
end