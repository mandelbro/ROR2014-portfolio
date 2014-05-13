CarrierWave.configure do |config|
  config.cache_dir = 'carrierwave'

  case Rails.env.to_sym

  when :development
    config.storage = :file
    config.root = File.join(Rails.root, 'public')

  when :production
    # the following configuration works for Amazon S3
    config.storage          = :fog
    config.fog_credentials  = {
      provider:                 'AWS',
      aws_access_key_id:        ENV['S3_KEY_ID'],
      aws_secret_access_key:    ENV['S3_SECRET_KEY'],
      region:                   ENV['S3_BUCKET_REGION']
    }
    config.fog_directory    = ENV['S3_BUCKET']
    config.fog_attributes   = {'Cache-Control'=>'max-age=315576000'}

  else
    # settings for the local filesystem
    config.storage = :file
    config.root = File.join(Rails.root, 'public')
  end
end
