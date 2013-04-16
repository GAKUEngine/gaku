FactoryGirl.define do
  
  factory :period_method_association, :class => Gaku::PeriodMethodAssociation do
    association(:admission_period)
    association(:admission_method)
  end

end