include ActionDispatch::TestProcess

FactoryBot.define do
  factory :attachment, class: Gaku::Attachment do
    name 'pic1'
    asset_file_name { 'avatar.jpg' }
    asset_content_type { 'image/jpg' }
  end

  trait :for_exam_portion do
    association :attachable, factory: :exam_portion
  end
end
