require 'spec_helper'

describe Gaku::ScholarshipStatus do

  context "validations" do
  	it { should have_many :students }
    it { should allow_mass_assignment_of :name }
    it { should validate_presence_of :name }
  end
end
