require 'spec_helper'

describe Gaku::SpecialtyApplication do

  context "validations" do 
    pending "has a valid factory" do
      should have_valid_factory(:specialty_application) 
    end
  	it { should belong_to :specialty }
  	it { should belong_to :admission }
  end
end
