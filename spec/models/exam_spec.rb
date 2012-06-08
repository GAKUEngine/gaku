require 'spec_helper'

describe Exam do
  context "validations" do 
    it { should have_valid_factory(:exam) }
    it { should have_many(:exam_scores) }
  end
end