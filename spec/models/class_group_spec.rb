require 'spec_helper'

describe ClassGroup do
  context "validations" do 
  	it { should have_valid_factory(:class_group) }
    pending { should have_and_belong_to_many(:courses) }
  end
end