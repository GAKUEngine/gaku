require 'spec_helper'

describe Gaku::Address do

  let(:country) { build(:country) }
  let(:state)   { build(:state) }
  let(:student) { create(:student) }
  let!(:address) { create(:address, country: country, addressable: student) }

  describe 'versioning' do
    it { should be_versioned }
  end

  describe 'relations' do
    it { should belong_to :country }
    it { should belong_to :state }
    it { should belong_to :addressable }
  end

  describe 'validations' do
    it { should validate_presence_of :address1 }
    it { should validate_presence_of :city }
    it { should validate_presence_of :country }
  end

  describe 'before_save' do
    it 'calls :ensure_first_is_primary on create' do
      built_address = build(:address)
      built_address.should_receive(:ensure_first_is_primary)
      built_address.save!
    end
  end

  describe '#make_primary' do
    it 'sets is_primary: false except self' do
      address2 =  create(:address, country: country, addressable: student, is_primary: true)
      address.send(:make_primary)
      address2.reload
      expect(address2.is_primary).to eq false
      expect(address.is_primary).to eq true
    end

    it 'sets is_primary: true' do
      address.send(:make_primary)
      expect(address.is_primary).to eq true
    end

    it 'updates address_widget field' do
      expect do
        address.send(:make_primary)
      end.to change(address.addressable, :primary_address)
    end
  end

  describe '#soft_delete' do
    it 'calls #decrement_count' do
      address.should_receive(:decrement_count)
      address.send(:soft_delete)
    end

    it 'sets is_deleted: true' do
      address.send(:soft_delete)
      expect(address.is_deleted).to eq true
    end
  end

  describe '#recover' do
    it 'calls #increment_count' do
      address.should_receive(:increment_count)
      address.send(:recover)
    end

    it 'sets is_deleted: false' do
      address.send(:recover)
      expect(address.is_deleted).to eq false
    end
  end

  describe '#reset_counter_cache' do
    it 'calls reset_counters' do
      address.addressable.class.should_receive(:reset_counters)
      address.send(:reset_counter_cache)
    end

    it "doesn't call reset_counters if istance_of Campus" do
      campus = create(:campus)
      campus_address = create(:address, addressable: campus)

      campus_address.addressable.class.should_not_receive(:reset_counters)
      campus_address.send(:reset_counter_cache)
    end

  end

  describe '#state_text' do
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
