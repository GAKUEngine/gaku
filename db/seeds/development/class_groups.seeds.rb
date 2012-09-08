#ActiveRecord::Fixtures.create_fixtures("#{Rails.root}/db/default/", 'class_groups')
ClassGroup.create(:name => 'Biology')
ClassGroup.create(:name => 'Math')
ClassGroup.create(:name => 'Literature')
