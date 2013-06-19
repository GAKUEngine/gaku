require 'spec_helper'

describe Gaku::Country do

  context "validations" do
    it { should have_many(:states) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:iso_name) }
    it { should validate_presence_of(:iso) }

  end

end
