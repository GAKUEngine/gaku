require 'spec_helper'

describe Gaku::StudentSpecialty do

  context "validations" do 
    it { should belong_to(:specialty) } 
    it { should belong_to(:student) }
  end
end
