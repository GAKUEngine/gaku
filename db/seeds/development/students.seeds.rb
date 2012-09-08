#ActiveRecord::Fixtures.create_fixtures("#{Rails.root}/db/default/", 'students')
Student.create(:name => 'John', :surname => 'Doe')
Student.create(:name => 'Anonime', :surname => 'Anonimized')
Student.create(:name => 'Amon', :surname => 'Tobin')
