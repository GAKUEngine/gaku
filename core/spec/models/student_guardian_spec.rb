require 'spec_helper'

describe Gaku::StudentGuardian do

  context "validations" do

    it { should belong_to(:student) }
    it { should belong_to(:guardian) }

  end

end
