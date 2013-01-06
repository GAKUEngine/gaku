require 'spec_helper'

describe Gaku::CommuteMethodType do

  context "validations" do
    it { should have_many(:commute_methods) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

end
