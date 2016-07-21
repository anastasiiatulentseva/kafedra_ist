class Workbook < ApplicationRecord

  belongs_to :subject

  validates_presence_of :name, :subject_id, :attachment

  mount_uploader :attachment, AttachmentUploader

  ALLOWED_FILE_EXTENSIONS = %w(doc zip pdf)

  def self.allowed_file_extensions
    ALLOWED_FILE_EXTENSIONS
  end

end

