require 'spec_helper'

describe Gaku::Address do

  context "validation" do
    let(:country) { build(:country) }
    let(:state)   { build(:state) }
    let(:address) { build(:address, country: country) }

    before do
      country.states.stub find_all_by_name_or_abbr: [state]
    end

    it 'is invalid without address1' do
      build(:address, address1:nil).should_not be_valid
    end

    it { should belong_to(:country) }
    it { should belong_to(:state) }
    it { should belong_to(:campus) }

    it { should belong_to(:addressable) }

    it { should validate_presence_of(:address1) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:country) }

    it 'is invalid without address1' do
      build(:address, address1:nil).should_not be_valid
    end

    it 'is invalid without city' do
      build(:address, city:nil).should_not be_valid
    end

    it 'is invalid without country' do
      build(:address, country:nil).should_not be_valid
    end

    it "state_name is not nil and country does not have any states" do
      address.state = nil
      address.state_name = 'alabama'
      address.should be_valid
    end
  end

  
  context '#state_text' do
    context 'state is blank' do
      let(:address) { build(:address, state: nil, state_name: 'virginia') }
      specify { address.state_text.should == 'virginia' }
    end

    context 'both name and abbr is present' do
      let(:state) { build(:state, name: 'virginia', abbr: 'va') }
      let(:address) { build(:address, state: state) }
      specify { address.state_text.should == 'va' }
    end

    context 'only name is present' do
      let(:state) { build(:state, name: 'virginia', abbr: nil) }
      let(:address) { build(:address, state: state) }
      specify { address.state_text.should == 'virginia' }
    end
  end
end
