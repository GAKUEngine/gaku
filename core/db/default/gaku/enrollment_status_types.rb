states = {
	:'Admitted' 										=> true,
	:'Enrolled' 										=> true,
	:'Visiting' 										=> true,
	:'Re-Admitted' 									=> true,
	:'On Exchange' 									=> true,
  :'Inactive' 										=> false,
	:'Pre-Admission' 								=> false,
	:'Graduated' 										=> false,
	:'Re-Enrolled'									=> false,
	:'Suspended' 										=> false,
	:'Expelled' 										=> false,
	:'Drop Out' 										=> false,
	:'On Leave/Temporary Absence'   => false
}

states.each do |name, state|
	Gaku::EnrollmentStatusType.where(:name => name, :is_active => state).first_or_create
end
