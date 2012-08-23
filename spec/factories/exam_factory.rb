# == Schema Information
#
# Table name: exams
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  description       :text
#  adjustments       :text
#  weight            :float
#  use_weighting   :boolean
#  grading_method_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

Factory.define :exam do |f|
  f.name "Math exam"
  f.weight 4
  f.after_build do |exam|
    exam.exam_portions << Factory.build(:exam_portion, :exam => exam)
  end
end
