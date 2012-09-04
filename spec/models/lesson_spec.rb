require 'spec_helper'

describe Lesson do

  context "validations" do 
  	it { should have_valid_factory(:lesson) }
  end
end