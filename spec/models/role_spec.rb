require 'spec_helper'

describe Role do
  context "validations" do 
  	it { should have_valid_factory(:role) }
  end
end