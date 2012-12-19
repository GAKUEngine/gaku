require 'spec_helper'

describe Gaku::StudentAddress do

  context "validations" do 
    it { should belong_to(:address) }
    it { should belong_to(:student) }

    it { should allow_mass_assignment_of(:student_id) }
    it { should allow_mass_assignment_of(:address_id) }
    it { should allow_mass_assignment_of(:is_primary) }
  end

  context 'methods' do
    xit 'ensure_primary_first'
    xit 'make_primary'
  end
  
end
