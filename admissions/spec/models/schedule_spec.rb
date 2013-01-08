require 'spec_helper'

describe Gaku::Schedule do

  context "validations" do
    it { should belong_to(:admission_period) }
  end

end
