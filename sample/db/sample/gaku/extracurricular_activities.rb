els = %w( Tennis Football Climbing )

els.each do |el|
  Gaku::ExtracurricularActivity.where(:name => el).first_or_create!
end
