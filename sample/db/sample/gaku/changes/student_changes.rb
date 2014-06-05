# # encoding: utf-8
# require 'shared_sample_data'

# say "Creating #{@count[:changes]} student changes ...".yellow

# commute_method_type = Gaku::CommuteMethodType.create!(name: 'Changed CommuteMethodType')
# scholarship_status = Gaku::ScholarshipStatus.create!(name: 'Changed Scholarship Status')
# enrollment_status = Gaku::EnrollmentStatus.create!(code: 'changed_enrollment_status')

# counter = 0

# batch_create(@count[:changes]) do
#   counter += 1
#   random_student = random_person.merge(
#                                         commute_method_type: @commute_method_type,
#                                         enrollment_status_code: @enrollment_status,
#                                         scholarship_status: @scholarship_status,
#                                         foreign_id_code: "foreign_id_code_#{counter}"
#                                       )

#   student = Gaku::Student.where(random_student).first_or_create!
#   student.name = Faker::Name.first_name
#   student.middle_name = Faker::Name.first_name
#   student.surname = Faker::Name.last_name
#   student.enrollment_status_code = enrollment_status.code
#   student.commute_method_type = commute_method_type
#   student.scholarship_status = scholarship_status
#   student.foreign_id_code = "foreign_code_#{counter + 100}"
#   student.save!

#   student.soft_delete
#   student.destroy
# end
