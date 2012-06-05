require 'spec_helper'

describe Teacher do
  context "validations" do 
  	it { should have_valid_factory(:teacher) }
  end
end