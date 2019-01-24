FactoryBot.define do

  factory :school_year, class: Gaku::SchoolYear do
    starting Time.now
    ending Time.now + 1.year

    factory :invalid_school_year do
      starting Time.now + 1.year
      ending Time.now
    end
  end

end
