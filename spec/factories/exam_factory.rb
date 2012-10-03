FactoryGirl.define do 
	factory :exam do 
    name "Math exam"
    weight 4
    use_weighting true
    after_build do |exam|
      exam_portions << FactoryGirl.build(:exam_portion, :exam => exam)
    end
  end
end