els = %w(
          JuniorRuby SeniorRuby RubyGuru
          JuniorJavascript SeniorJavascript JavascriptGuru
          JuniorClojure SeniorClojure ClojureGuru
          JuniorScala SeniorScala ScalaGuru
        )

say "Creating #{els.size} achievements ...".yellow

els.each do |el|
  Gaku::Achievement.where(name: el).first_or_create!
end
