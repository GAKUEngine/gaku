require 'spec_helper_models'

describe Gaku::ContactCreation do
  describe '#initialize' do
    it 'instantiates new Contact object' do
      service = described_class.new(data: 'data')
      contact = service.contact
      errors  = service.errors

      expect(contact).to be_new_record
      expect(contact).to be_instance_of Gaku::Contact

      expect(errors).to eq []
    end
  end

  describe '#save' do
    context 'successful save' do
      it 'returns true' do
        contact_attributes = build(:contact).attributes

        service = described_class.new(contact_attributes)
        expect do
          expect(service.save).to be_truthy
        end.to change { Gaku::Contact.count }.by(1)
      end

      context 'when it belongs to a contactable' do
        context 'when contactable has no contacts' do
          let(:student) { create(:student) }
          let(:contact_attributes) { build(:contact).attributes.merge(contactable: student) }

          it 'creates a primary contact' do
            service = described_class.new(contact_attributes)
            expect do
              expect(service.save).to be_truthy
            end.to change { Gaku::Contact.count }.by(1)

            contact = service.contact
            expect(contact).to be_primary
          end
        end

        context 'when contactable has contacts' do
          let!(:student) { create(:student) }
          let(:contact_attributes) { build(:contact).attributes.merge(contactable: student) }
          let!(:contact_1) do
            service = described_class.new(contact_attributes)
            service.save
            service.contact
          end

          it 'makes other contacts non-primary' do
            service = described_class.new(contact_attributes)
            expect do
              expect(service.save).to be_truthy
            end.to change { Gaku::Contact.count }.by(1)

            student.reload
            contact_1.reload
            contact_2 = service.contact

            expect(student.contacts.count).to eq 2
            expect(student.contacts).to include contact_1
            expect(student.contacts).to include contact_2

            expect(contact_2).not_to be_primary
            expect(contact_1).to be_primary
          end
        end

        context 'when contactable has primary_contact attribute' do
          let(:student) { create(:student) }
          let(:contact_attributes) { build(:contact).attributes.merge(contactable: student, data: 'test@example.com') }

          it 'sets primary contact widget for contactable' do
            service = described_class.new(contact_attributes)
            expect do
              expect(service.save).to be_truthy
            end.to change { Gaku::Contact.count }.by(1)

            student.reload
            expect(student.contact_widget).to include 'Email'
            expect(student.contact_widget).to include 'test@example.com'
          end
        end
      end
    end
  end
end
