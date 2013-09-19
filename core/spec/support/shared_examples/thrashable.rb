shared_examples_for 'thrashable' do
  describe 'methods' do
    it { should respond_to :soft_delete }
    it { should respond_to :recover }
  end
end
