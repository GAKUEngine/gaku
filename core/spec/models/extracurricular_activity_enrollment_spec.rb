require 'spec_helper_models'

describe Gaku::ExtracurricularActivityEnrollment do

  describe 'associations' do
    it { should belong_to :extracurricular_activity }
    it { should belong_to :student }
    it { should have_many :school_roles }
  end

  describe 'validations' do
    it { should validate_presence_of :extracurricular_activity_id }
    it { should validate_presence_of :student_id }

    it { should validate_uniqueness_of(:student_id).scoped_to(:extracurricular_activity_id).with_message(/Already enrolled to the extracurricular activity!/) }
  end

end
