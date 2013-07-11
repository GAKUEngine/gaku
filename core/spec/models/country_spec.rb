require 'spec_helper'

describe Gaku::Country do

  describe 'associations' do
    it { should have_many :states }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :iso_name }
  end

end
