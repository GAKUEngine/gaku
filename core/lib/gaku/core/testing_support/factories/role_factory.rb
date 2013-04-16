FactoryGirl.define do
  factory :role, :class => Gaku::Role do
    name "Role #1"
  end

  factory :admin_role, :parent => :role do
    name 'admin'
  end

  factory :principal_role, :parent => :role do
    name 'principal'
  end

  factory :vice_principal_role, :parent => :role do
    name 'vice_principal'
  end

  factory :student_role, :parent => :role do
    name 'student'
  end

  factory :guardian_role, :parent => :role do
    name 'guardian'
  end

  factory :staff_role, :parent => :role do
    name 'staff'
  end

  factory :instructor_role, :parent => :role do
    name 'instructor'
  end

  factory :counselor_role, :parent => :role do
    name 'counselor'
  end

end
