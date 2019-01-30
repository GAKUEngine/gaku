shared_examples_for 'student_reviewable' do
  it { is_expected.to have_many :student_reviews }
end
