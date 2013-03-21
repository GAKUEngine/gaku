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

unless Gaku::Teacher.count > 50
  50.times do
    Gaku::Teacher.create!(:name => Faker::Name.first_name, :surname => Faker::Name.last_name)
  end
end
