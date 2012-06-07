require 'spec_helper'

describe Country do
  context "validations" do 
    it { should have_valid_factory(:country) }
    it { should have_many(:states) }
  end
end