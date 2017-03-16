require 'spec_helper_models'

describe Gaku::UserCreator do
  describe '#initialize' do
    it 'instantiates new User object' do
      expect(Gaku::User).to receive(:new).with(email: 'gaku@engine.io').once.and_return(Gaku::User.new)
      Gaku::UserCreator.new(email: 'gaku@engine.io')
    end

    context 'when there is no active preset setting' do
      it 'sets default locale to English' do
        allow(Gaku::Preset).to receive(:active).and_return(nil)
        user = Gaku::UserCreator.new(email: 'gaku@engine.io').get_user

        expect(user.settings[:locale]).to eq 'en'
      end
    end

    context 'when there is existing active preset setting' do
      it 'sets default locale to preset language' do
        allow(Gaku::Preset).to receive(:active).and_return(OpenStruct.new(locale: { 'language' => 'de' }))
        user = Gaku::UserCreator.new(email: 'gaku@engine.io').get_user

        expect(user.settings[:locale]).to eq 'de'
      end
    end
  end

  describe '#save' do
    it 'creates new user and return true' do
      service = Gaku::UserCreator.new(username: 'gaku', email: 'gaku@engine.io', password: '123456')
      expect { expect(service.save).to be_truthy }.to change { Gaku::User.count }.by(1)
    end

    context 'when failed to create' do
      it 'does not create new user and return false' do
        allow(Gaku::User).to receive(:valid?).and_return(false)
        service = Gaku::UserCreator.new(username: 'gaku')
        expect { expect(service.save).to be_falsy }.not_to change { Gaku::User.count }
      end
    end
  end

  describe '#save!' do
    it 'creates new user and does not raise exception' do
      service = Gaku::UserCreator.new(username: 'gaku', email: 'gaku@engine.io', password: '123456')
      expect { expect { service.save! }.not_to raise_error }.to change { Gaku::User.count }.by(1)
    end

    context 'when failed to create' do
      it 'does not create new user and raise exception' do
        allow(Gaku::User).to receive(:valid?).and_return(false)
        service = Gaku::UserCreator.new(username: 'gaku')
        expect { expect { service.save! }.to raise_error }.not_to change { Gaku::User.count }
      end
    end
  end
end
