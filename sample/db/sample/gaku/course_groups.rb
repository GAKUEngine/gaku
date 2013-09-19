els = %w( Ruby Node.js Clojure )

say "Creating #{els.size} course groups ...".yellow

els.each do |el|
  Gaku::CourseGroup.where(name: el).first_or_create!
end
