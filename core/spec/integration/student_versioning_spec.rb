require 'spec_helper'

describe 'Student Versioning' do

  let(:student) { create(:student) }

  it 'saves update history', versioning: true do
    expect do
      student.name = 'Changed Name'
      student.save
    end.to change(Gaku::Versioning::StudentVersion, :count).by(1)
  end

end
