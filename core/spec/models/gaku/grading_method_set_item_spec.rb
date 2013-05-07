require 'spec_helper'

describe Gaku::GradingMethodSetItem do
  context "validations" do
    it { should belong_to :grading_method }
    it { should belong_to :grading_method_set }
    it { should allow_mass_assignment_of :grading_method_id }
    it { should allow_mass_assignment_of :grading_method_set_id }

  end
end
