FactoryBot.define do

  factory :semester, class: Gaku::Semester do
    starting { Date.parse('2013-04-08') }
    ending { Date.parse('2014-04-08') }

    factory :invalid_semester do
      starting { Date.parse('2014-04-08') }
      ending { Date.parse('2013-04-08') }
    end

    factory :active_semester do
      starting { Date.today - 1.day }
      ending  { Date.today + 1.day }
    end

    factory :upcomming_semester do
      starting { Date.today + 1.day }
      ending  { Date.today + 2.day }
    end

    factory :ended_semester do
      starting { Date.today  - 2.day }
      ending  { Date.today - 1.day }
    end

  end

end
