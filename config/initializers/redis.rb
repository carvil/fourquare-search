REDIS_CONFIG = YAML::load(File.open("#{Rails.root}/config/redis.yml"))[Rails.env]

$redis = Redis.new(host: REDIS_CONFIG['host'], port: REDIS_CONFIG['port'], db: REDIS_CONFIG['database'])
