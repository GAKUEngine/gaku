if Rails.env.test?
  $redis = Redis.new(db: 15)
else
  if ENV['REDIS_HOST']
    $redis = Redis.new(host: ENV['REDIS_HOST'])
  else
    $redis = Redis.new
  end
end
