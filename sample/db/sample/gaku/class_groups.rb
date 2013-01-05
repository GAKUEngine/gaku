# encoding: utf-8

class_groups = [
  { :name => 'Ms. Moore 3rd Grade', :grade => 3 },
  { :name => 'Advanced', :grade => 5 },
  { :name => 'Mr. Nagae', :grade => 7 },
  { :name => 'A組', :grade => 1 },
  { :name => 'A組', :grade => 2 },
  { :name => 'さくら組', :grade => 0 },
  { :name => 'マルチメディア専攻', :grade => 1}
]

class_groups.each do |class_group|
  Gaku::ClassGroup.where(class_group).first_or_create!
end
