require 'spec_helper'

describe Gaku::Achievement do

  context "validations" do

    it { should have_many(:students).through(:student_achievements) }
    it { should belong_to :school }

    it { should validate_presence_of(:name) }
  end
end
