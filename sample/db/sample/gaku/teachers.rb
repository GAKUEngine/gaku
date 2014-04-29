require 'rake-progressbar'
require 'shared_sample_data'

teachers = [
  { name: 'Vassil', surname: 'Kalkov' },
  { name: 'Marta', surname: 'Kostova' },
  { name: 'Georgi', surname: 'Tapalilov' },
  { name: 'Radoslav', surname: 'Georgiev' },
  { name: 'Rei', surname: 'Kagetsuki' }
]

say 'Creating predefined teachers...'.yellow
teachers.each { |teacher| create_teacher_with_full_info(teacher) }

say "Creating #{@count[:teachers]} teachers...".yellow
batch_create(@count[:teachers]) { create_teacher_with_full_info }
