require 'spec_helper_models'

describe Gaku::Preset, type: :model do

  it 'responds to .default' do
    expect(Gaku::Preset).to respond_to(:default)
  end

  it 'responds to .active' do
    expect(Gaku::Preset).to respond_to(:active)
  end

  it 'responds to .per_page' do
    expect(Gaku::Preset).to respond_to(:per_page)
  end

  it 'responds to .address' do
    expect(Gaku::Preset).to respond_to(:address)
  end

end
