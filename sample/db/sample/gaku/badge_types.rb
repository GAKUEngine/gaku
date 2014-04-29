els = %w( JuniorRuby SeniorRuby RubyGuru
          JuniorJavascript SeniorJavascript JavascriptGuru
          JuniorClojure SeniorClojure ClojureGuru
          JuniorScala SeniorScala ScalaGuru )

say "Creating #{els.size} badges ...".yellow

els.each { |el|  Gaku::BadgeType.where(name: el).first_or_create! }
