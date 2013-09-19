els = %w(
          RubyDeveloper JavascriptDeveloper ClojureDeveloper
          ScalaDeveloper PythonDeveloper GoDeveloper
        )

say "Creating #{els.size} specialties ...".yellow

els.each do |el|
  Gaku::Specialty.where(name: el).first_or_create!
end
