#ActiveRecord::Fixtures.create_fixtures("#{Rails.root}/db/default/", 'courses')
Gaku::Course.create(:code => "spring2012")
Gaku::Course.create(:code => "fall2012")
