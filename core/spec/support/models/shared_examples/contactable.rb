shared_examples_for 'contactable' do
  it { is_expected.to have_many :contacts }
end
