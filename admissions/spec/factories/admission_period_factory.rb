FactoryGirl.define do
  factory :admission_period_no_methods, :class => Gaku::AdmissionPeriod do
    name 'Admission Period 1'
  end

  factory :admission_period, :class => Gaku::AdmissionPeriod do
    name { Faker::Name.name }
    after_create do |period|
      period.period_method_associations << FactoryGirl.create(:period_method_association, 
                                                            admission_period_id: period.id,
                                                            admission_method_id: FactoryGirl.create(:admission_method_regular).id)
      period.period_method_associations << FactoryGirl.create(:period_method_association,
                                                            admission_period_id: period.id,
                                                            admission_method_id: FactoryGirl.create(:admission_method_international).id)
      period.save!
    end
  end

  factory :admission_period_with_methods, :class => Gaku::AdmissionPeriod do
    name { Faker::Name.name }
    after_create do |period|
      period.period_method_associations << FactoryGirl.create(:period_method_association, 
                                                            admission_period_id: period.id,
                                                            admission_method_id: FactoryGirl.create(:admission_method_with_phases).id)
      period.period_method_associations << FactoryGirl.create(:period_method_association,
                                                            admission_period_id: period.id,
                                                            admission_method_id: FactoryGirl.create(:admission_method_with_phases).id)
      period.save!
    end
  end

end