require 'spec_helper'

describe Gaku::State do

  describe 'associations' do
    it { should belong_to :country }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :country }
  end

  before(:all) { Gaku::State.destroy_all }

  it 'can find a state by name or abbr' do
    state = create(:state, name: 'California', abbr: 'CA')
    Gaku::State.find_all_by_name_or_abbr('California').should include(state)
    Gaku::State.find_all_by_name_or_abbr('CA').should include(state)
  end

  it 'can find all states group by country numcode' do
    state = create(:state)
    Gaku::State.states_group_by_country_iso.should == { state.country_iso => [[state.id, state.name]] }
  end
end
