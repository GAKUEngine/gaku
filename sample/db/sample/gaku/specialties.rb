els = %w(
          RubyDeveloper JavascriptDeveloper ClojureDeveloper
          ScalaDeveloper PythonDeveloper GoDeveloper
        )

els.each do |el|
  Gaku::Specialty.where(:name => el).first_or_create!
end
