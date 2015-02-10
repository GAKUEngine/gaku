shared_examples_for 'student_reviewable' do
  it { should have_many :student_reviews }
end
