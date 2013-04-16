require 'spec_helper'

describe 'Student Versioning' do

  before do
    @student = create(:student)
  end

  it 'saves update history' do
    expect do
      @student.name = "Changed Name"
      @student.save
    end.to change(Gaku::StudentVersion, :count).by 1
  end

end
