require 'rake-progressbar'

teachers = [
  { :name => 'Vassil', :surname => 'Kalkov' },
  { :name => 'Marta', :surname => 'Kostova' },
  { :name => 'Georgi', :surname => 'Tapalilov'},
  { :name => 'Radoslav', :surname => 'Georgiev'},
  { :name => 'Rei', :surname => 'Kagetsuki'}
]

teachers.each do |teacher|
  Gaku::Teacher.where(teacher).first_or_create!
end

teachers_count = 50

unless Gaku::Teacher.count > teachers_count
  bar = RakeProgressbar.new(teachers_count)
  teachers_count.times do
    Gaku::Teacher.create!(:name => Faker::Name.first_name, :surname => Faker::Name.last_name)
    bar.inc
  end
  bar.finished
end
