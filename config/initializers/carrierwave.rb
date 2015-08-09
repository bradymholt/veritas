CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => Setting.cached.aws_access_key,                        # required
    :aws_secret_access_key  => Setting.cached.aws_secret_access_key,                        # required
    :endpoint               => 'http://s3.amazonaws.com', # optional, defaults to nil
    #:host                   => Setting.cached.aws_host_name || nil # optional, defaults to nil
    #:region                 => 'eu-west-1',                  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = Setting.cached.aws_bucket_name                     # required
  config.fog_public     = true                                   # optional, defaults to true
  config.fog_attributes = {
    'Cache-Control'=>'max-age=315576000',  # optional, defaults to {}
    'x-amz-storage-class' => 'REDUCED_REDUNDANCY'
  }
end
