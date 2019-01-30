shared_examples_for 'enrollable' do
  it { is_expected.to have_many(:enrollments).dependent(:destroy) }
  it { is_expected.to have_many(:students).through(:enrollments) }
end
