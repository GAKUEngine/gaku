require 'spec_helper_models'

module Gaku
  describe ContactUpdation do
    let!(:student) { create(:student) }
    let!(:contact_type) { create(:contact_type, name: 'Email') }
    let!(:contact) { create(:contact, data: 'gaku@example.net', contactable: student, contact_type: contact_type) }
    let!(:service) { service = described_class.new(contact) }

    describe '#initialize' do
      it 'instantiates contact object' do
        contact = service.contact
        errors  = service.errors

        expect(contact).to eq contact
        expect(errors).to eq []
      end
    end

    describe '#update' do
      context 'when successful to update' do
        it 'updates contact and returns true' do
          expect(service.update(data: 'new_data@example.net')).to eq true

          contact.reload

          expect(contact.data).to eq 'new_data@example.net'
        end

        context 'set contact primary' do
          context 'when contactable has contacts' do
            let!(:other_contact) { create(:contact, contactable: student, primary: true) }

            it 'makes other contacts non-primary' do
              expect(service.update(primary: true)).to eq true

              student.reload
              contact.reload
              other_contact.reload

              expect(other_contact).not_to be_primary
              expect(contact).to be_primary
            end

            context 'when contactable has primary_contact attribute' do
              it 'sets primary contact widget for contactable' do
                expect(service.update(primary: true)).to eq true

                student.reload
                contact.reload
                other_contact.reload

                expect(student.contact_widget).to eq 'Email: gaku@example.net'
              end
            end
          end
        end
      end

      context 'when failed to update' do
        let(:errors) { ActiveModel::Errors.new(contact).add(:base, 'an error has occured') }

        before do
          allow_any_instance_of(Contact).to receive(:save).and_return(false)
          expect_any_instance_of(Contact).to receive(:errors)
        end

        it 'sets errors and returns false' do
          expect(service.update(data: 'new_data@example.net')).to eq false

          contact.reload

          expect(contact).not_to eq 'new_data@example.net'
        end
      end
    end
  end
end
