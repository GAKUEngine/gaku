FactoryGirl.define do
  factory :school do
    name "Nagoya City University"
    slogan "Draw the individual potencial"
    description "Nagoya University description"
    founded Date.new(1950, 4, 1)
    principal "Hajime Togari"
  end
end