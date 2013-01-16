# Array format ['en status', 'ja status', 'is_active?']
statuses = [
	['Applicant', 		          '志願', 			  false ],
	['Admitted', 					      '入学',    			true	],
	['Enrolled',					      '在学',				  true	],
	['Transfered In',			      '転入',			  	true	],
	['Transfered Out',		      '転出',			    false	],
	['Course Transfer In',			'編入',				  true	],
	['Course Transfer Out',		  '編出',			    false	],
	['Visiting',					      '留学',				  true	],
	['Re-Admitted',				      '再入学',				true	],
	['On For-Credit Exchange',	'単位認定留学',	true	],
	['On Non-Credit Exchange',	'休学留学',			true	],
	['Repeat',                	'留年',			    true	],
	['Heald Back',	            '原級留置',			true	],
  ['Inactive',					      '休学',					false	],
	['Graduated',					      '卒業',					false	],
	['Re-Enrolled', 			      '復学', 				false	],
	['Suspended', 				      '退学', 				false	],
	['Expelled',					      '停学', 				false	],
	['Dropped Out',				      '自主退学', 		false	],
	['Terminal Leave',		      '除籍', 				false	],
	['On Leave', 					      '一時自主退学', false	],
	['Extended Absence', 	      '長期自主退学', false	],
	['Deleted', 					      '削除' , 				false	]
]

statuses.each do |status|
	I18n.locale = :en
	es = Gaku::EnrollmentStatus.where(:name => status[0], :is_active => status[2], :immutable => true).first_or_create!

	I18n.locale = :ja
	es.update_attribute(:name,  status[1])
end

I18n.locale = nil
