require 'spec_helper'

describe Gaku::Campus do
	context "validations" do

    it_behaves_like 'contactable'
    it_behaves_like 'avatarable'

		it { should belong_to(:school) }
		it { should have_one(:address) }

    it { should validate_presence_of(:name) }

		it { should allow_mass_assignment_of :name }
		it { should allow_mass_assignment_of :school_id }
	end

  context 'counter_cache' do

    let!(:campus) { FactoryGirl.create(:campus) }


    context 'addresses_count' do

      let(:address) { build(:address) }
      let(:campus_with_address) { create(:campus, :with_address) }

      it "increments addresses_count" do
        expect do
          campus.address = address
        end.to change { campus.reload.addresses_count }.by 1
      end

      it "decrements addresses_count" do
        expect do
          campus_with_address.address = nil
        end.to change { campus_with_address.reload.addresses_count }.by -1
      end
    end

    context 'contacts_count' do

      let(:contact) { build(:contact) }
      let(:campus_with_contact) { create(:campus, :with_one_contact) }

      it "increments contacts_count" do
        expect do
          campus.contacts << contact
        end.to change { campus.reload.contacts_count }.by 1
      end

      it "decrements contacts_count" do
        expect do
          campus_with_contact.contacts.last.destroy
        end.to change { campus_with_contact.reload.contacts_count }.by -1
      end
    end


  end

end
