class MessageAttachmentUploader < CarrierWave::Uploader::Base
  storage :fog

  def store_dir
    "messages/#{model.class.to_s.underscore}"
  end
end
