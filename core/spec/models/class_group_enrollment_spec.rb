require 'spec_helper_models'

describe Gaku::ClassGroupEnrollment do

  describe 'associations' do
    it { should belong_to :class_group }
    it { should belong_to :enrollmentable }
  end

  describe 'validations' do
    it { should validate_presence_of :class_group_id }
    it { should validate_presence_of :enrollmentable_id }
    it { should validate_presence_of :enrollmentable_type }
    it { should validate_uniqueness_of(:class_group_id).scoped_to([:enrollmentable_id, :enrollmentable_type]).with_message(/Class group already enrolled/) }
    it { should ensure_inclusion_of(:enrollmentable_type).in_array( %w(Gaku::Course) ) }
  end


end
