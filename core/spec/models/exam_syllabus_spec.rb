require 'spec_helper_models'

describe Gaku::ExamSyllabus, type: :model do

  describe 'relations' do
    it { should belong_to :exam }
    it { should belong_to :syllabus }
  end

  describe 'validations' do
    it { should validate_presence_of :exam_id }
    it { should validate_presence_of :syllabus_id }
    it { should validate_uniqueness_of(:syllabus_id).scoped_to(:exam_id).with_message(/Exam already added!/) }
  end

end
