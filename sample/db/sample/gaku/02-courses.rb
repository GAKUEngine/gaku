# encoding: utf-8

courses = [
  {syllabus: Gaku::Syllabus.where(code: 'B01').first, code: "Spring 2013"},
  {syllabus: Gaku::Syllabus.where(code: 'MT').first, code: "2013年(秋)"},
  {syllabus: Gaku::Syllabus.where(code: 'RB1').first, code: "Prof. Why"}
]

say "Creating #{courses.size} courses ...".yellow

courses.each do |course|
  Gaku::Course.where(code: course[:code], syllabus_id: course[:syllabus]).first_or_create!
end
