require 'spec_helper'

describe Gaku::Attachment do

  context "validations" do
  	it { should belong_to(:attachable) }

  	it { should allow_mass_assignment_of :name }
  	it { should allow_mass_assignment_of :description }
  end
end
