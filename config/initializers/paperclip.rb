Paperclip.interpolates(:s3_eu_url) do |att, style|
  "#{att.s3_protocol}://s3.eu-central-1.amazonaws.com/#{att.bucket_name}/#{att.path(style)}"
end

AWS.config(region: 'eu-central-1')
