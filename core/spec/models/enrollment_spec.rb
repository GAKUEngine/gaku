require 'spec_helper_models'

describe Gaku::Enrollment do

  describe 'associations' do
    it { should belong_to :student }
    it { should belong_to :enrollmentable }
  end

  describe 'validations' do
    it { should validate_presence_of :student_id }
    it { should validate_presence_of :enrollmentable_id }
    it { should validate_presence_of :enrollmentable_type }
    it { should validate_uniqueness_of(:student_id).scoped_to([:enrollmentable_id, :enrollmentable_type]).with_message(/Student already enrolled/) }
    it { should ensure_inclusion_of(:enrollmentable_type).in_array( %w(Gaku::Course Gaku::ClassGroup Gaku::ExtracurricularActivity) ) }

  end


end
