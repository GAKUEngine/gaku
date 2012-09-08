#ActiveRecord::Fixtures.create_fixtures("#{Rails.root}/db/default/", 'courses')
Course.create(:code => "fall2011")
Course.create(:code => "spring2012")
Course.create(:code => "fall2012")
