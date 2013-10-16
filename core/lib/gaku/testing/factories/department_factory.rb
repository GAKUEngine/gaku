FactoryGirl.define  do

  factory :department, class: Gaku::Department do
    name 'Mathematics'

    factory :invalid_department do
      name nil
    end
  end

end
