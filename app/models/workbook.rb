class Workbook < ApplicationRecord

  belongs_to :subject

  validates_presence_of :name, :subject_id, :attachment

  mount_uploader :attachment, AttachmentUploader

end
