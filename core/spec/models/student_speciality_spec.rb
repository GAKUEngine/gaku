require 'spec_helper'

describe Gaku::StudentSpecialty do

  context "validations" do 
  	it { should have_valid_factory(:student_specialty) }

    it { should belong_to(:specialty) } 
    it { should belong_to(:student) }
  end
end
