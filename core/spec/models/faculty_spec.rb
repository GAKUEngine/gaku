require 'spec_helper'

describe Gaku::Faculty do

  context "validations" do
    it { should have_valid_factory(:faculty) }
    it { should have_many(:roles) }
    it { should have_many(:students) } 
    it { should have_many(:class_groups) }
    it { should have_many(:courses) }
    it { should have_many(:addresses) }
    it { should have_many(:contacts) }
  end

end
