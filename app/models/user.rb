class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates_presence_of :name

  mount_uploader :picture, PictureUploader

  ALLOWED_FILE_EXTENSIONS = %w(jpg jpeg gif png)

  def self.allowed_file_extensions
    ALLOWED_FILE_EXTENSIONS
  end

end
