require 'spec_helper_models'

describe Gaku::Address do

  let(:state)   { build(:state) }
  let(:country) { create(:country) }
  let(:student) { create(:student, primary_address: '') }
  let(:address) { create(:address, country: country, addressable: student) }

  describe 'versioning' do
    it { should be_versioned }
  end

  describe '.deleted' do
    let!(:active_address) { create(:address, deleted: false) }
    let!(:deleted_address) { create(:address, deleted: true) }

    it 'returns records that are not deleted' do
      expect(Gaku::Address.deleted).to be == [deleted_address]
    end
  end

  describe '#soft_delete' do
    it 'calls #decrement_count' do
      address.should_receive(:decrement_count)
      address.soft_delete
    end

    it 'sets deleted: true' do
      address.soft_delete
      expect(address.deleted).to eq true
    end
  end

  describe '#recover' do
    it 'calls #increment_count' do
      address.should_receive(:increment_count)
      address.recover
    end

    it 'sets deleted: false' do
      address.recover
      expect(address.deleted).to eq false
    end
  end

  describe '.after_destroy' do
    describe '#reset_counter_cache' do
      it 'calls reset_counters' do
        address.addressable.class.should_receive(:reset_counters)
        address.destroy
      end

      it "doesn't call reset_counters if istance_of Campus" do
        campus = create(:campus)
        campus_address = create(:address, addressable: campus)

        campus_address.addressable.class.should_not_receive(:reset_counters)
        address.destroy
      end
    end
  end

end
