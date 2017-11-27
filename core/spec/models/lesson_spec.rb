require 'spec_helper_models'

describe Gaku::Lesson, type: :model do

  describe 'relations' do
    it { should belong_to :lesson_plan }
    it { should have_many :attendances }
  end

  describe 'validations' do
    it { should validate_presence_of :lesson_plan }
  end

end
