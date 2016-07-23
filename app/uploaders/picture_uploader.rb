# encoding: utf-8

class PictureUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage Rails.application.config.carrierwave_storage

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Process files as they are uploaded:
  process :resize_to_fit => [225, 225]
  process :round

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
    User::ALLOWED_FILE_EXTENSIONS
  end

end
