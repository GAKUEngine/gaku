require 'spec_helper'

describe Gaku::Student do

  context "validations" do
    it { should have_one(:admission) }
  end
end
