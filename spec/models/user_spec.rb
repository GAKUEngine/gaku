require 'spec_helper'

describe User do

  context "validations" do 
  	it { should have_valid_factory(:user) }
  end
  
end