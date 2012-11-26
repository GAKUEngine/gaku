require 'spec_helper'

describe Gaku::Schedule do

  context "validations" do 
  	it { should have_valid_factory(:schedule) }
  end
  
end
