if Rails.env.test?
  $redis = Redis.new(db: 15)
else
  $redis = Redis.new
end