class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates_presence_of :name

  mount_uploader :picture, PictureUploader

  scope :registered, -> {where(guest: false)}
  scope :with_role, ->(role) { where("roles_mask & #{2**ROLES.index(role)} > 0") }
  scope :without_role, -> { where(roles_mask: nil)}

  ROLES = %i[student teacher banned admin]
  ALLOWED_FILE_EXTENSIONS = %w(jpg jpeg gif png)

  self.per_page = 7

  def self.allowed_file_extensions
    ALLOWED_FILE_EXTENSIONS
  end

  def roles=(roles)
    roles = [*roles].map { |r| r.to_sym }
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask.to_i || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def has_role?(role)
    roles.include?(role)
  end

  def admin?
    self.has_role?(:admin)
  end

  def student?
    self.has_role?(:student)
  end

  def teacher?
    self.has_role?(:teacher)
  end

  def banned?
    self.has_role?(:banned)
  end

end
