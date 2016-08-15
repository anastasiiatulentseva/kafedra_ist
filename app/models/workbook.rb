class Workbook < ApplicationRecord

  belongs_to :subject
  belongs_to :user

  validates_presence_of :name, :subject_id, :user_id, :attachment

  scope :with_subject_ids, ->(ids) { where(subject_id: ids)}

  mount_uploader :attachment, AttachmentUploader

  ALLOWED_FILE_EXTENSIONS = %w(doc zip pdf)

  def self.allowed_file_extensions
    ALLOWED_FILE_EXTENSIONS
  end

end

