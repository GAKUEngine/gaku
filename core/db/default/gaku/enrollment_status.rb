# Array format ['en status', 'ja status', 'is_active?']
statuses = [

	['Pre-Admission', 		'Japanese Pre-Admission ', 			false ],
	['Admitted', 					'Japanese Admitted',    				true	],
	['Enrolled',					'Japanese Enrolled',						true	],
	['Transfered In',			'Japanese Transfered In',				true	],
	['Transfered Out',		'Japanese Transfered Out',			false	],
	['Visiting',					'Japanese Visiting',						true	],
	['Re-Admitted',				'Japanese Re-Admitted',					true	],
	['On Exchange',				'Japanese On Exchange',					true	],
  ['Inactive',					'Japanese Inactive',						false	],
	['Graduated',					'Japanese Graduated',						false	],
	['Re-Enrolled', 			'Japanese Re-Enrolled', 				false	],
	['Suspended', 				'Japanese Suspended', 					false	],
	['Expelled',					'Japanese Expelled', 						false	],
	['Dropped Out',				'Japanese Dropped Out', 				false	],
	['On Leave', 					'Japanese On Leave', 						false	],
	['Extended Absence', 	'Japanese Extended Absence', 		false	],
	['Deleted', 					'Japanese Deleted' , 						false	]
]

statuses.each do |status|
	I18n.locale = :en
	es = Gaku::EnrollmentStatus.where(:name => status[0], :is_active => status[2], :immutable => true).first_or_create!

	I18n.locale = :ja
	es.update_attribute(:name,  status[1])
end

I18n.locale = nil
