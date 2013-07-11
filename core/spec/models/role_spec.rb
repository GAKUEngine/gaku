require 'spec_helper'

describe Gaku::Role do

  describe 'associations' do
    it { should have_many :user_roles }
    it { should have_many(:roles).through(:user_roles) }

    it { should belong_to :class_group_enrollment }
    it { should belong_to :extracurricular_activity_enrollment }
    it { should belong_to :faculty }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end

end
