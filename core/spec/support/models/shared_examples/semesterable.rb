shared_examples_for 'semesterable' do
  it { should have_many :semester_connectors }
  it { should have_many(:semesters).through(:semester_connectors) }
end
