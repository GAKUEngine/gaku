els = %w( Tennis Football Basketball Handball Climbing Running Swimming Rugby PingPong Chess Fitness )

say "Creating #{els.size} extracurricular activities ...".yellow
els.each { |el| Gaku::ExtracurricularActivity.where(name: el).first_or_create! }
