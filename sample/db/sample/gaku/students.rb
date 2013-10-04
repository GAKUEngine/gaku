# encoding: utf-8
require 'shared_sample_data'

say 'Creating predefined students ...'.yellow
students = [
  { name: 'Anonime', surname: 'Anonimized', birth_date: Date.new(1982,1,1), enrollment_status_code: @enrollment_status },
  { name: 'Amon', surname: 'Tobin', birth_date: Date.new(1983,1,1), enrollment_status_code: @enrollment_status },
  { name: '零', surname: '影月', enrollment_status_code: @enrollment_status },
  { name: 'サニー', surname: 'スノー', enrollment_status_code: @enrollment_status }
]

create_student_with_full_info(@john_doe)
students.each do |student|
  create_student_with_full_info(student)
end


say "Creating #{@count[:students]} students ...".yellow

batch_create(@count[:students]) do
  create_student_with_full_info
end