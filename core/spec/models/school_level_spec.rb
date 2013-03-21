require 'spec_helper'
  describe Gaku::SchoolLevel do

  context "validation" do
    it { should belong_to :school }
    it { should validate_presence_of :title }
  end
end
