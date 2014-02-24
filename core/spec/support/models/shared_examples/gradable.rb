shared_examples_for 'gradable' do
  it { should has_many :grading_method_connectors, as: :gradable }
  it { should have_many(:grading_methods).through(:grading_method_connectors) }
end
