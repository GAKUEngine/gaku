require 'spec_helper'

describe 'Student Contact Versioning' do

  before do
    @student = create(:student, :with_contact)
    @student.reload
    @contact = @student.contacts.first
  end

  it 'saves update history' do
    expect do
      @contact.data = "Changed"
      @contact.save
    end.to change(Version, :count).by 1

    version = Version.last

    version.join_model.should eq "Gaku::Student"
    version.joined_resource_id.should eq @student.id
  end

end
