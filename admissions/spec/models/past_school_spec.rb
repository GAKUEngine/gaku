require 'spec_helper'

describe Gaku::PastSchool do

  context "validations" do 
  	it { should belong_to :school }
  	it { should have_many :achievements }
  	it { should have_many :simple_grades }
  end
end
