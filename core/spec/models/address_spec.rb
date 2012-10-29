require 'spec_helper'

describe Address do

  context "validation" do
    let(:country) { mock_model(Country, :states => [state]) }
    let(:state)   { stub_model(State, :name => 'maryland', :abbr => 'md') }
    let(:address) { build(:address, :country => country) }

    before do
      country.states.stub :find_all_by_name_or_abbr => [state]
    end

    it { should have_valid_factory(:address) }
    it { should belong_to(:country) }
    it { should belong_to(:state) }
    it { should have_many(:student_addresses) } 
    it { should have_many(:students) } 
    it { should have_many(:guardian_addresses) } 
    it { should have_many(:guardians) }
    it { should have_one(:campus) } 
 

    it { should validate_presence_of(:address1) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:country) }

    it "state_name is not nil and country does not have any states" do
      address.state = nil
      address.state_name = 'alabama'
      address.should be_valid
    end
  end

  context ".default" do
    before do
      @default_country_id = AppConfig[:default_country_id]
      new_country = create(:country)
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
