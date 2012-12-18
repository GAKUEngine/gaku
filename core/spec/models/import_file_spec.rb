require 'spec_helper'

describe Gaku::ImportFile do

  context "validations" do 

    it { should allow_mass_assignment_of :context }
    it { should allow_mass_assignment_of :data_file }
    it { should allow_mass_assignment_of :importer_type }
  end
  
end
