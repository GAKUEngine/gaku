types = { 
	:'Admitted' 										=> true,
	:'Enrolled' 										=> true,
	:'Inactive' 										=> true,
	:'Visiting' 										=> true,
	:'Re-Admitted' 									=> true,
	:'On Exchange' 									=> true,
	:'Pre-Admission' 								=> false,
	:'Graduated' 										=> false,
	:'Re-Enrolled'									=> false,
	:'Suspended' 										=> false,
	:'Expelled' 										=> false,
	:'Drop Out' 										=> false,
	:'On Leave / Temporary Absence' => false
}

types.each do |name, active_state|
	Gaku::EnrollmentStatusType.create!(:name => name, :is_active => active_state)	
end
