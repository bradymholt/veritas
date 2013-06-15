CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => 'AKIAJ7SYBB5DAYVLOAOA',                        # required
    :aws_secret_access_key  => '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',                        # required
    :endpoint               => 'http://s3.amazonaws.com/' # optional, defaults to nil
    #:region                 => 'eu-west-1',                  # optional, defaults to 'us-east-1'
    #:host                   => 'https://veritasclass.s3.amazonaws.com'             # optional, defaults to nil
  }
  config.fog_directory  = 'veritasclass'                     # required
  config.fog_public     = true                                   # optional, defaults to true
  config.fog_attributes = {
    'Cache-Control'=>'max-age=315576000',  # optional, defaults to {}
    'x-amz-storage-class' => 'REDUCED_REDUNDANCY'
  } 
end