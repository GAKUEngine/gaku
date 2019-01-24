FactoryBot.define do
  factory :level, class: Gaku::Level do
    sequence(:name) { |n| "High #{n}" }
    school
  end
end
