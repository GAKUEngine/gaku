require 'spec_helper'

describe Gaku::User do

  context "validations" do 
  	it { should have_valid_factory(:user) }
  end
  
end
