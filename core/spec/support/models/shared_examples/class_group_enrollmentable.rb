shared_examples_for 'class_group_enrollmentable' do
   it { should have_many(:class_group_enrollments).dependent(:destroy) }
   it { should have_many(:class_groups).through(:class_group_enrollments) }
end
