require 'spec_helper'

describe Country do

  context "validations" do 
    it { should have_valid_factory(:country) }
    it { should have_many(:states) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:iso_name) }
  end
  
end