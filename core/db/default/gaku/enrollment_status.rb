states = {
	:'Pre-Admission' 								=> false,
	:'Admitted' 										=> true,
	:'Enrolled' 										=> true,
	:'Transfered In' 					      => true,
	:'Transfered Out' 					    => false,
	:'Visiting' 										=> true,
	:'Re-Admitted' 									=> true,
	:'On Exchange' 									=> true,
  :'Inactive' 										=> false,
	:'Graduated' 										=> false,
	:'Re-Enrolled'									=> false,
	:'Suspended' 										=> false,
	:'Expelled' 										=> false,
	:'Dropped Out' 									=> false,
	:'On Leave'                     => false,
	:'Extended Absence'             => false,
	:'Deleted' 										  => false
}

states.each do |name, state|
	Gaku::EnrollmentStatus.where(:name => name, :is_active => state, :immutable => true).first_or_create!
end
