include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :attachment, :class => Gaku::Attachment do
    name 'pic1'
    asset { fixture_file_upload(Rails.root + "../support/120x120.jpg", 'image/jpg') }
    is_deleted 0
  end

  trait :for_exam_portion do
    association :attachable, :factory => :exam_portion
  end
end
