require 'spec_helper'

describe Attachment do

  context "validations" do 
  	pending { should have_valid_factory(:attachment) }

  	it { should belong_to(:attachable) }

  	it { should allow_mass_assignment_of :name }
  	it { should allow_mass_assignment_of :description }

  end
end
