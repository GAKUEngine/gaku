require 'spec_helper'

describe Faculty do
  context "validations" do
    it { should have_valid_factory(:faculty) }
    it { should have_many(:roles) }
    
  end
end
