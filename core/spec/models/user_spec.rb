require 'spec_helper'

describe Gaku::User do

  context "validations" do

    it { should have_many :user_roles }
    it { should have_many(:roles).through(:user_roles) }

    it { should allow_mass_assignment_of :username }
    it { should allow_mass_assignment_of :login }
    it { should respond_to :login }

    it { should validate_presence_of :username }
  end

end
