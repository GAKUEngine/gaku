require 'spec_helper'

describe Gaku::UserRole do

  context "validations" do
    it { should belong_to :user }
    it { should belong_to :role }

    it { should allow_mass_assignment_of :user_id }
    it { should allow_mass_assignment_of :role_id }
  end

end
