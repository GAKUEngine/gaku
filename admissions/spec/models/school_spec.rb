require 'spec_helper'

describe Gaku::School do

  context "validations" do 
  	it { should have_many :past_schools }
  end
end
