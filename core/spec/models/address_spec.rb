require 'spec_helper_models'

describe Gaku::Address, type: :model do
  let(:state)   { build(:state) }
  let(:country) { create(:country) }
  let(:student) { create(:student) }
  let(:address) { create(:address, country: country, addressable: student) }

  describe 'relations' do
    it { is_expected.to belong_to :country }
    it { is_expected.to belong_to :state }
    it { is_expected.to belong_to :addressable }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :address1 }
    it { is_expected.to validate_presence_of :city }
    it { is_expected.to validate_presence_of :country }
  end

  describe '.before_save' do
    it 'calls :ensure_first_primary on create' do
      built_address = build(:address)
      built_address.should_receive(:ensure_first_primary)
      built_address.save!
    end
  end

  describe 'addressable scopes' do
    let!(:student_address) { create(:address, addressable_type: 'Gaku::Student') }
    let!(:teacher_address) { create(:address, addressable_type: 'Gaku::Teacher') }
    let!(:guardian_address) { create(:address, addressable_type: 'Gaku::Guardian') }

    describe '.students' do
      it 'returns records with address type Student' do
        expect(Gaku::Address.students).to eq [student_address]
      end
    end

    describe '.teachers' do
      it 'returns records with address type Teacher' do
        expect(Gaku::Address.teachers).to eq [teacher_address]
      end
    end

    describe '.guardians' do
      it 'returns records with address type Guardian' do
        expect(Gaku::Address.guardians).to eq [guardian_address]
      end
    end
  end

  describe '#ensure_first_primary' do
    it 'sets first address as primary' do
      address1 = create(:address, addressable: student)
      student.reload
      address2 = create(:address, addressable: student)
      student.reload

      expect(address1.primary).to be_truthy
      expect(address2.primary).to be_falsey
    end
  end

  describe '#make_primary' do
    it 'sets primary: false except self' do
      address2 = create(:address, country: country, addressable: student, primary: true)
      address.make_primary
      address2.reload
      expect(address2.primary).to be_falsey
      expect(address.primary).to be_truthy
    end

    it 'sets primary: true' do
      address.make_primary
      expect(address.primary).to eq true
    end

    xit 'updates primary_address field' do
      expect do
        address.make_primary
      end.to change(address.addressable.reload, :primary_address)
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

  describe '#campus_address?' do
    context "addressable_type is 'Gaku::Campus'" do
      let(:address) { build(:address, addressable_type: 'Gaku::Campus') }

      specify { expect(address).to be_addressable_type }
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
