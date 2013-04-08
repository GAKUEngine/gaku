els = %w(
          JuniorRuby SeniorRuby RubyGuru
          JuniorJavascript SeniorJavascript JavascriptGuru
          JuniorClojure SeniorClojure ClojureGuru
          JuniorScala SeniorScala ScalaGuru
        )

els.each do |el|
  Gaku::Achievement.where(:name => el).first_or_create!
end
