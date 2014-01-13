departments = [
  {
    name: 'Mathematics',
    name_ja: 'Japanese Mathematics'
  }
]

departments.each do |d|
  I18n.locale = :en
  department = Gaku::Department.where(name: d[:name]).first_or_create!

  I18n.locale = :ja
  department.update_attributes(name: d[:name_ja])
end
