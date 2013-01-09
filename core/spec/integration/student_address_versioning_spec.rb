require 'spec_helper'

describe 'Student Address Versioning' do

  before do
    @student = create(:student)
    @address = create(:address)
    @student_address = create(:student_address, :student => @student, :address => @address)
  end

  it 'saves update history' do
    expect do
      @address.address1 = "Changed"
      @address.save
    end.to change(Version, :count).by 1

    version = Version.last

    version.join_model.should eq "Gaku::StudentAddress"
    version.joined_resource_id.should eq @student.id
  end

end
