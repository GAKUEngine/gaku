FactoryGirl.define do

  factory :semester, class: Gaku::Semester do
    starting { Date.parse('2013-04-08') }
    ending { Date.parse('2014-04-08') }

    factory :invalid_semester do
      starting { Date.parse('2014-04-08') }
      ending { Date.parse('2013-04-08') }
    end

    factory :active_semester do
      starting { Time.now - 1.day }
      ending  { Time.now + 1.day }
    end

    factory :not_started_semester do
      starting { Time.now + 1.day }
      ending  { Time.now + 2.day }
    end

    factory :ended_semester do
      starting { Time.now  - 2.day }
      ending  { Time.now - 1.day }
    end

  end

end
