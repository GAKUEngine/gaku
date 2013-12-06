require 'spec_helper'

describe 'Student Address Versioning' do

  let(:student) { create(:student, :with_address) }
  let(:address) { student.addresses.first }

  it 'saves update history', type: 'address', versioning: true do
    expect do
      address.address1 = 'Changed'
      address.save
    end.to change(Gaku::Versioning::AddressVersion, :count).by(1)

    version = Gaku::Versioning::AddressVersion.last

    version.join_model.should eq 'Gaku::Student'
    version.joined_resource_id.should eq student.id
  end

end
