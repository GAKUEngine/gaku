require 'spec_helper'

describe Gaku::Schedule do

  context "validations" do
    it { should allow_mass_assignment_of :starting }
    it { should allow_mass_assignment_of :ending }
    it { should allow_mass_assignment_of :repeat }
  end

end
