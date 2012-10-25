FactoryGirl.define do
  factory :exam_schedule do
    association(:exam_portion)
    association(:schedule)
  end
end
