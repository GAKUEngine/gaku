require 'spec_helper'

describe Gaku::Specialty do

  context "validations" do
  	it { should have_many :specialty_applications }
  end
end
