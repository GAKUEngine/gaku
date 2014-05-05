shared_examples_for 'person' do
  it { should validate_presence_of :name }
  it { should validate_presence_of :surname }
end
