# -*- encoding: utf-8 -*-
# Array format ['en status', 'ja status', 'is_active?']
statuses = [
	['applicant',           'Applicant', 		          '志願', 			  false ], #DO NOT CHANGE ORDER
	['admitted',            'Admitted', 					    '入学',    			true	], #DO NOT CHANGE ORDER
	['enrolled',            'Enrolled',					      '在学',				  true	], #DO NOT CHANGE ORDER
	['transferred_in',      'Transfered In',			    '転入',			  	true	],
	['transferred_out',     'Transfered Out',		      '転出',			    false	],
	['course_transfer_in',  'Course Transfer In',			'編入',				  true	],
	['course_transfer_out', 'Course Transfer Out',		'編出',			    false	],
	['visiting',            'Visiting',					      '留学',				  true	],
	['re_admitted',         'Re-Admitted',				    '再入学',				true	],
	['for_credit_exchange', 'For-Credit Exchange',	  '単位認定留学',	true	],
	['non_credit_exchange', 'Non-Credit Exchange',	  '休学留学',			true	],
	['repeat',              'Repeat',                	'留年',			    true	],
	['held_back',           'Held Back',	            '原級留置',			true	],
  ['inactive',            'Inactive',					      '休学',					false	],
	['graduated',           'Graduated',					      '卒業',					false	],
	['re_enrolled',         'Re-Enrolled', 			      '復学', 				false	],
	['suspended',           'Suspended', 				      '退学', 				false	],
	['expelled',            'Expelled',					      '停学', 				false	],
	['dropped_out',         'Dropped Out',				      '自主退学', 		false	],
	['terminal_leave',      'Terminal Leave',		      '除籍', 				false	],
	['on_leave',            'On Leave', 					      '一時自主退学', false	],
	['extended_absence',    'Extended Absence', 	      '長期自主退学', false	],
	['deleted',             'Deleted', 					      '削除' , 				false	]
]

statuses.each do |status|
	I18n.locale = :en
	es = Gaku::EnrollmentStatus.where(:code => status[0], :name => status[1], :is_active => status[3], :immutable => true).first_or_create!

	I18n.locale = :ja
	es.update_attribute(:name,  status[2])
end

I18n.locale = nil
