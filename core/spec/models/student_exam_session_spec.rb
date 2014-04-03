require 'spec_helper_models'

describe Gaku::StudentExamSession do

  describe 'validations' do
    it { should validate_presence_of :exam_session_id }
    it { should validate_presence_of :student_id }
    it { should validate_uniqueness_of(:student_id).scoped_to(:exam_session_id) }
  end

  describe 'relations' do
    it { should belong_to :exam_session }
    it { should belong_to :student }
  end

end
