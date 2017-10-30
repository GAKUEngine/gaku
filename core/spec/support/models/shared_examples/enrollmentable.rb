shared_examples_for 'enrollable' do
  it { should have_many(:enrollments).dependent(:destroy) }
  it { should have_many(:students).through(:enrollments) }
end
