FactoryGirl.define do
  factory :admission_period_no_methods, :class => Gaku::AdmissionPeriod do
    name 'Admission Period 1'
  end

  factory :admission_period, :class => Gaku::AdmissionPeriod do
    name 'Regular Admission 2013'
    after_build do |period|
      period.period_method_associations << FactoryGirl.build(:period_method_association, 
                                                            admission_period: period,
                                                            admission_method: FactoryGirl.build(:admission_method_regular))
      period.period_method_associations << FactoryGirl.build(:period_method_association,
                                                            admission_period: period,
                                                            admission_method: FactoryGirl.build(:admission_method_international))
    end
  end

end