require 'spec_helper'

describe Gaku::GuardianAddress do

  context "validations" do 
    it { should belong_to(:address) }
    it { should belong_to(:guardian) }

    it { should allow_mass_assignment_of :guardian_id }
    it { should allow_mass_assignment_of :address_id }
    it { should allow_mass_assignment_of :is_primary }
  end

  context 'methods' do
    xit 'make_primary'
  end
  
end
