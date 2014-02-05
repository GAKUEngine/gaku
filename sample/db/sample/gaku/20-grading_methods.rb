grading_methods = [
  {
    name: 'Score',
    method: 'score',
    description: 'Straight Score',
    curved: false
  },
  {
    name: 'Curved Score',
    method: 'score',
    description: 'Curved Score',
    curved: true
  },
  {
    name: 'Percentage',
    method: 'percentage',
    description: 'Straight Percentage',
    curved: false
  },
  {
    name: 'Curved Percentage',
    method: 'percentage',
    description: 'Curved Percentage',
    curved: true
  }
]

say "Creating #{grading_methods.size} grading methods ...".yellow

grading_methods.each do |grading_method|
  Gaku::GradingMethod.where(grading_method).first_or_create!
end
