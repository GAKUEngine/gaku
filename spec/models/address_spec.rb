require 'spec_helper'

describe Address do

  context "validation" do
    let(:country) { mock_model(Country, :states => [state]) }
    let(:state) { stub_model(State, :name => 'maryland', :abbr => 'md') }
    let(:address) { FactoryGirl.build(:address, :country => country) }

    before do
      country.states.stub :find_all_by_name_or_abbr => [state]
    end

    it { should have_valid_factory(:address) }
    it { should belong_to(:country) }
    it { should belong_to(:state) }
    it { should have_and_belong_to_many(:students) } 

    it { should validate_presence_of(:address1) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:country) }

    it "state_name is not nil and country does not have any states" do
      address.state = nil
      address.state_name = 'alabama'
      address.should be_valid
    end

    it "errors when state_name is nil" do
      address.state_name = nil
      address.state = nil
      address.should_not be_valid
    end

    it "full state name is in state_name and country does contain that state" do
      address.state_name = 'alabama'
      # called by state_validate to set up state_id.
      # Perhaps this should be a before_validation instead?
      address.should be_valid
      address.state.should_not be_nil
      address.state_name.should be_nil
    end

    it "state abbr is in state_name and country does contain that state" do
      address.state_name = state.abbr
      address.should be_valid
      address.state_id.should_not be_nil
      address.state_name.should be_nil
    end

    it "state is entered but country does not contain that state" do
      address.state = state
      address.country = stub_model(Country)
      address.valid?
      address.errors["state"].should == ['is invalid']
    end

    it "both state and state_name are entered but country does not contain the state" do
      address.state = state
      address.state_name = 'maryland'
      address.country = stub_model(Country)
      address.should be_valid
      address.state_id.should be_nil
    end

    it "both state and state_name are entered and country does contain the state" do
      address.state = state
      address.state_name = 'maryland'
      address.should be_valid
      address.state_name.should be_nil
    end

  end

  context ".default" do
    before do
      @default_country_id = AppConfig[:default_country_id]
      new_country = Factory(:country)
      AppConfig[:default_country_id] = new_country.id
    end

    after do
      AppConfig[:default_country_id] = @default_country_id
    end
    it "sets up a new record with Spree::Config[:default_country_id]" do
      Address.default.country.should == Country.find(AppConfig[:default_country_id])
    end

    # Regression test for #1142
    it "uses the first available country if :default_country_id is set to an invalid value" do
      AppConfig[:default_country_id] = "0"
      Address.default.country.should == Country.first
    end
  end

  context '#state_text' do
    context 'state is blank' do
      let(:address) { stub_model(Address, :state => nil, :state_name => 'virginia') }
      specify { address.state_text.should == 'virginia' }
    end

    context 'both name and abbr is present' do
      let(:state) { stub_model(State, :name => 'virginia', :abbr => 'va') }
      let(:address) { stub_model(Address, :state => state) }
      specify { address.state_text.should == 'va' }
    end

    context 'only name is present' do
      let(:state) { stub_model(State, :name => 'virginia', :abbr => nil) }
      let(:address) { stub_model(Address, :state => state) }
      specify { address.state_text.should == 'virginia' }
    end
  end
end