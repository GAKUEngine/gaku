shared_examples_for 'gradable' do
  it { should have_many :grading_method_connectors }
  it { should have_many(:grading_methods).through(:grading_method_connectors) }
end
