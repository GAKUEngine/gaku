FactoryGirl.define do
  factory :attendance, :class => Gaku::Attendance do
    reason 'headache'
    description 'Headache, because of too much Maths'
  end
end
