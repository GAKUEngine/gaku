require 'spec_helper_models'

describe Gaku::Lesson, type: :model do
  describe 'relations' do
    it { is_expected.to belong_to :lesson_plan }
    it { is_expected.to have_many :attendances }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :lesson_plan }
  end
end
