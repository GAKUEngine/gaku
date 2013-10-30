FactoryGirl.define do

  factory :extracurricular_activity, class: Gaku::ExtracurricularActivity do
    name 'tennis'

    factory :invalid_extracurricular_activity do
      name nil
    end
  end

end
