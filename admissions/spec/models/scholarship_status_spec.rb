require 'spec_helper'

describe Gaku::ScholarshipStatus do

  context "validations" do 
  	it { should have_many :admissions }
  end
end
