shared_examples_for 'avatarable' do
  it { is_expected.to have_attached_file :picture }
end
