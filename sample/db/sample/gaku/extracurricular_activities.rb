els = %w( Tennis Football Basketball Handball Climbing Running Swimming Rugby PingPong Chess Fitness )

els.each do |el|
  Gaku::ExtracurricularActivity.where(:name => el).first_or_create!
end
