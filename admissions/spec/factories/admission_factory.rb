FactoryGirl.define do
  factory :admission, :class => Gaku::Admission do
    
    after_build do |admission|
      admission.student = FactoryGirl.build(:student)
      admission.admission_method = FactoryGirl.build(:admission_method_regular)
      admission_period = FactoryGirl.build(:admission_period)
    end
    
  end
end