require 'spec_helper'

describe Exam do
  context "validations" do 
    it { should belong_to(:course) }
  end
end