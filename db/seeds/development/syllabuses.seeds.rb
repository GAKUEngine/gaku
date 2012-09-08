#ActiveRecord::Fixtures.create_fixtures("#{Rails.root}/db/default/", 'syllabuses')
Syllabus.create(:name => "Biology Syllabus")
Syllabus.create(:name => "Math Syllabus")
Syllabus.create(:name => "Literature Syllabus")
