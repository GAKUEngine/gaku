require 'spec_helper'

describe Gaku::ScholarshipStatus do

  context "validations" do 
  	it { should have_many :students }
  end
end
