require 'spec_helper'

describe Gaku::User do

  describe 'associations' do
    it { should have_many :user_roles }
    it { should have_many(:roles).through(:user_roles) }
  end

  describe 'validations' do
    it { should validate_presence_of :username }
  end

  it { should respond_to :login }

end
