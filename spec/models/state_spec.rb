require 'spec_helper'

describe State do

  context "validations" do 
    it { should have_valid_factory(:state) }
    it { should belong_to(:country) }
  end

  before(:all) do
    State.destroy_all
  end

  it "can find a state by name or abbr" do
    state = Factory(:state, :name => "California", :abbr => "CA")
    State.find_all_by_name_or_abbr("California").should include(state)
    State.find_all_by_name_or_abbr("CA").should include(state)
  end

  it "can find all states group by country id" do
    state = Factory(:state)
    State.states_group_by_country_id.should == { state.country_id.to_s => [[state.id, state.name]] }
  end
end# == Schema Information
#
# Table name: states
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  abbr       :string(255)
#  country_id :integer
#

