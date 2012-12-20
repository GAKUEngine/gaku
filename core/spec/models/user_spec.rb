require 'spec_helper'

describe Gaku::User do

  context "validations" do

    it { should allow_mass_assignment_of :username }
    it { should allow_mass_assignment_of :login }
    it { should respond_to(:login) }
  end

end
