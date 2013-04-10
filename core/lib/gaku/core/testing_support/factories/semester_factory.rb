FactoryGirl.define do
  factory :semester, :class => Gaku::Semester do
    starting { Date.parse('2013-04-08') }
    ending { Date.parse('2014-04-08') }
  end
end
