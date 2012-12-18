require 'spec_helper'

describe Gaku::Install do

  context "validations" do 

    it { should allow_mass_assignment_of :email }
    it { should allow_mass_assignment_of :remember_me }

  end
end
