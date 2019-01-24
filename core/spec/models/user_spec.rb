require 'spec_helper_models'

describe Gaku::User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many :user_roles }
    it { is_expected.to have_many(:roles).through(:user_roles) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :username }
    it { is_expected.to validate_uniqueness_of :username }
  end

  it { is_expected.to respond_to :login }
  it { is_expected.to respond_to :login= }

  describe 'mixins' do
    let!(:modules) { described_class.included_modules }

    it 'includes devise modules' do
      expect(modules).to include(Devise::Models::Authenticatable)
      expect(modules).to include(Devise::Models::DatabaseAuthenticatable)
      expect(modules).to include(Devise::Models::Registerable)
      expect(modules).to include(Devise::Models::Recoverable)
      expect(modules).to include(Devise::Models::Rememberable)
      expect(modules).to include(Devise::Models::Trackable)
      expect(modules).to include(Devise::Models::Validatable)
    end
  end

  describe 'scopes' do
    describe '.admin' do
      before do
        @admin = create(:admin_user)
        @student = create(:student_user)
      end

      it 'returns users with role admin' do
        expect(described_class.admin).to eq([@admin])
      end
    end
  end

  describe '#to_s' do
    let(:user) { described_class.new(username: 'ruby') }

    it 'returns username' do
      expect(user.to_s).to eq 'ruby'
    end
  end

  describe '#role?' do
    let!(:user) { create(:admin_user) }

    context 'when role is matched' do
      it 'returns true' do
        expect(user.role?(:admin)).to eq true
      end
    end

    context 'when role is not matched' do
      it 'returns false' do
        expect(user.role?(:student)).to eq false
      end
    end
  end
end
