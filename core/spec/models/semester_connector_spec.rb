require 'spec_helper_models'

describe Gaku::SemesterConnector do

  describe 'associations' do
    it { should belong_to :semester }
    it { should belong_to :semesterable }
  end

  describe 'validations' do
    it { should validate_presence_of :semester_id }
    it { should validate_presence_of :semesterable_id }
    it { should validate_presence_of :semesterable_type }

    it { should validate_uniqueness_of(:semester_id).scoped_to([:semesterable_type, :semesterable_id]).with_message(/Semester already added/) }
    it { should ensure_inclusion_of(:semesterable_type).in_array( %w(Gaku::ClassGroup Gaku::Course) ) }

  end

end
