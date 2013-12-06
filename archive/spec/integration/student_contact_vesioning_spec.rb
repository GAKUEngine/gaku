require 'spec_helper'

describe 'Student Contact Versioning' do

  let(:student) { create(:student, :with_contact) }
  let(:contact) { student.contacts.first }

  it 'saves update history', versioning: true do
    expect do
      contact.data = 'Changed'
      contact.save!
      contact.reload
    end.to change(Gaku::Versioning::ContactVersion, :count).by 1

    version = Gaku::Versioning::ContactVersion.last

    version.join_model.should eq 'Gaku::Student'
    version.joined_resource_id.should eq student.id
  end

end
