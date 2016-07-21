# encoding: utf-8

class AttachmentUploader < CarrierWave::Uploader::Base

  storage Rails.application.config.carrierwave_storage

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
    Workbook::ALLOWED_FILE_EXTENSIONS
  end

end
