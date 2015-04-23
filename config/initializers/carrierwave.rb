CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => 'AKIAJXC5VFDHVRF2T5LA',                        # required
    :aws_secret_access_key  => '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',                        # required
    #:region                 => 'eu-central-1',                  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'mmonster-messages'                     # required
  config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end
