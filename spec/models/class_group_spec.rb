require 'spec_helper'

describe ClassGroup do
  context "validations" do 
    it { should have_and_belong_to_many(:courses) }
  end
end