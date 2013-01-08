require 'spec_helper'

describe Gaku::Exam do

  context "validations" do
    it { should belong_to(:admission_phase) }
  end

end
