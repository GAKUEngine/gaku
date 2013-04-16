FactoryGirl.define do

  factory :admission_method_without_phases, :class => Gaku::AdmissionMethod do
    name { Faker::Name.name }
  end

  factory :admission_method_with_phases, :class => Gaku::AdmissionMethod do
    name { Faker::Name.name }
    after_create do |method|
      method.admission_phases << FactoryGirl.create(:admission_phase_exam, :admission_method => method)
      method.admission_phases << FactoryGirl.create(:admission_phase_interview, :admission_method => method)
      method.save!
    end
  end

  factory :admission_method_regular, :class => Gaku::AdmissionMethod do
    name 'Regular Admissions'
    after_create do |method|
      method.admission_phases << FactoryGirl.create(:admission_phase_exam, :admission_method => method)
      method.admission_phases << FactoryGirl.create(:admission_phase_interview, :admission_method => method)
      method.save!
    end
  end

  factory :admission_method_international, :class => Gaku::AdmissionMethod do
    name 'International Division Admissions'
    after_create do |method|
      method.admission_phases << FactoryGirl.create(:admission_phase_exam, :admission_method => method)
      method.admission_phases << FactoryGirl.create(:admission_phase_interview, :admission_method => method)
      method.admission_phases << FactoryGirl.create(:admission_phase_lang_exam, :admission_method => method)
      method.save!
    end
  end
  
end