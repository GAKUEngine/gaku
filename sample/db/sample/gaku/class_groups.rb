# encoding: utf-8

school_year = Gaku::SchoolYear.where(starting: Time.now - 3.months, ending: Time.now + 9.months).first_or_create!
active_semester = Gaku::Semester.where(starting: Time.now - 2.months, ending: Time.now + 2.months).first_or_create!
not_active_semester = Gaku::Semester.where(starting: Time.now + 3.months, ending: Time.now + 9.months).first_or_create!

class_groups = [
  { name: 'Ms. Moore 3rd Grade', grade: 3 },
  { name: 'Advanced', grade: 5 },
  { name: 'Mr. Nagae', grade: 7 },
  { name: 'A組', grade: 1 },
  { name: 'A組', grade: 2 },
  { name: 'さくら組', grade: 0 },
  { name: 'マルチメディア専攻', grade: 1 },
  { name: 'Mr.Kalkov', grade: 7 },
  { name: 'Mr.Kagetsuki', grade: 7 },
  { name: 'Mr.Tapalilov', grade: 7 },
  { name: 'Mr.Georgiev', grade: 7 },
  { name: 'Mrs.Kostova', grade: 7 }
]

say "Creating #{class_groups.size} class groups ...".yellow

class_groups.each do |class_group|
  Gaku::ClassGroup.where(class_group).first_or_create!
end

active_class_group = Gaku::ClassGroup.where(name: 'Mr.Kalkov').first
not_active_class_group = Gaku::ClassGroup.where(name: 'Mr.Kagetsuki').first

Gaku::SemesterConnector.where(semesterable_id: active_class_group.id, semesterable_type: "Gaku::ClassGroup", semester_id: active_semester.id).first_or_create!
Gaku::SemesterConnector.where(semesterable_id: not_active_class_group.id, semesterable_type: "Gaku::ClassGroup", semester_id: not_active_semester.id).first_or_create!
