Factory.define :exam do |f|
  f.name "Math exam"
  f.weight 4
  f.use_weighting true
  f.after_build do |exam|
    exam.exam_portions << Factory.build(:exam_portion, :exam => exam)
  end

end
