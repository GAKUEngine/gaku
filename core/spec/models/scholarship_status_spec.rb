require 'spec_helper'

describe Gaku::ScholarshipStatus do

  context "validations" do 
  	it { should belong_to :student }
  end
end
