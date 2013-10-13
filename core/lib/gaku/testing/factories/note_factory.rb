FactoryGirl.define do

  factory :note, class: Gaku::Note do
    title 'Excellent'
    content 'Excellent student'

    factory :invalid_note do
      title nil
    end
  end

end
