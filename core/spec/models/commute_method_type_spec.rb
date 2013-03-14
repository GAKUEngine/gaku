require 'spec_helper'

describe Gaku::CommuteMethodType do

  context "validations" do
    it { should have_many(:students) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

end
