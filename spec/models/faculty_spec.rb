require 'spec_helper'

describe Faculty do
  context "validations" do
    it { should have_valid_factory(:faculty) }
    it { should have_many(:roles) }
    it { should have_many(:students) } 
    it { should have_many(:class_groups) }
    it { should have_many(:courses) }
    it { should belong_to(:profile) }
    it { should belong_to(:users) }
    it { should have_many(:addresses) }
    it { should have_many(:contacts) }
  end
end
