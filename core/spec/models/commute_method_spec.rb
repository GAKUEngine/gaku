require 'spec_helper'

describe Gaku::CommuteMethod do

  context "validations" do
    it { should have_one :student }
    it { should belong_to :commute_method_type }
    it { should validate_presence_of :commute_method_type_id }
  end

end
