require 'spec_helper'

describe Gaku::CommuteMethod do

  context "validations" do
    it { should have_one(:student) }
    it { should belong_to(:commute_method_type) }
  end

end
