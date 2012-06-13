require 'spec_helper'

describe Note do

  context "validations" do 
  	it { should have_valid_factory(:note) }
  	it { should belong_to(:student) }
  end
  
end