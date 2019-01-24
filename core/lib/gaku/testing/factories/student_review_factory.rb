# add assigments when integrate with GradingMethodConnector
%w[class_group].each do |resource|
  FactoryBot.define do
    factory "#{resource}_student_review", class: Gaku::StudentReview do
      content { 'Excellent student' }
      student
      student_review_category
      association :student_reviewable, factory: resource
    end
  end
end
