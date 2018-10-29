class User < ApplicationRecord

  enum role: [:user, :manager, :admin]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,:recoverable,
         :registerable, :rememberable, :validatable, :authenticatable

  has_one :attachment, as: :attachable, dependent: :destroy
  has_many :project_users
  has_many :projects, through: :project_users, dependent: :destroy

  validates :name, presence: true

  accepts_nested_attributes_for :attachment, allow_destroy: true

  def fetch_attachment
    self.attachment.nil? ? self.build_attachment : self.attachment
  end

  def active_for_authentication?
    super and self.active?
  end

  def inactive_message
    "Your account has been disabled!"
  end

end
