shared_examples_for 'gradable' do
  it { is_expected.to have_many :grading_method_connectors }
  it { is_expected.to have_many(:grading_methods).through(:grading_method_connectors) }
end
