class Workbook < ApplicationRecord

  belongs_to :subject
  belongs_to :teacher_profile

  validates_presence_of :name, :subject_id, :teacher_profile_id, :attachment

  scope :with_subject_ids, ->(ids) { where(subject_id: ids)}
  scope :simple, -> { with_subject_ids(Subject.simple) }
  scope :special, -> { with_subject_ids(Subject.special) }
  mount_uploader :attachment, AttachmentUploader

  ALLOWED_FILE_EXTENSIONS = %w(doc zip pdf)

  def self.allowed_file_extensions
    ALLOWED_FILE_EXTENSIONS
  end

end

