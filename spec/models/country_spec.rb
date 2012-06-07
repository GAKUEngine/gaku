require 'spec_helper'

describe Country do
  context "validations" do 
    it { should have_valid_factory(:country) }
    pending { should have_one(:zone) }
    pending { should have_one(:zone_member) }
    it { should have_many(:states) }
  end
end