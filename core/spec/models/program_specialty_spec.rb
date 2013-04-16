require 'spec_helper'
  describe Gaku::ProgramSpecialty do

  context "validation" do
    it { should belong_to :program }
    it { should belong_to :specialty }
  end
end
