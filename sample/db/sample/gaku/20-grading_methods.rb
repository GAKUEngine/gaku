grading_methods = [
  {
    name: 'Score',
    grading_type: 'score',
    description: 'Straight Score',
    curved: false
  },
  {
    name: 'Curved Score',
    grading_type: 'score',
    description: 'Curved Score',
    curved: true
  },
  {
    name: 'Percentage',
    grading_type: 'percentage',
    description: 'Straight Percentage',
    curved: false
  },
  {
    name: 'Curved Percentage',
    grading_type: 'percentage',
    description: 'Curved Percentage',
    curved: true
  }
]

say "Creating #{grading_methods.size} grading methods ...".yellow

grading_methods.each do |grading_method|
  Gaku::GradingMethod.where(grading_method).first_or_create!
end
