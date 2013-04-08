els = %w( Ruby Node.js Clojure )

els.each do |el|
  Gaku::CourseGroup.where(:name => el).first_or_create!
end
