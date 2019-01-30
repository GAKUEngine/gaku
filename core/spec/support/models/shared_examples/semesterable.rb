shared_examples_for 'semesterable' do
  it { is_expected.to have_many :semester_connectors }
  it { is_expected.to have_many(:semesters).through(:semester_connectors) }
end
