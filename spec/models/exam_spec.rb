require 'spec_helper'

describe Exam do
  context "validations" do 
    it { should have_valid_factory(:exam) }
  end
end