# frozen_string_literal: true

class User < ApplicationRecord
  enum role: %i[user manager admin]

  paginates_per DEFAULT_PER_PAGE
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable,
         :registerable, :rememberable, :validatable, :authenticatable

  has_one :attachment, as: :attachable, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :project_users
  has_many :projects, through: :project_users, dependent: :destroy
  has_many :time_logs, dependent: :destroy

  validates :name, presence: true

  accepts_nested_attributes_for :attachment, allow_destroy: true

  before_save :generate_authentication_token!

  def fetch_attachment
    attachment.nil? ? build_attachment : attachment
  end

  def active_for_authentication?
    super && active?
  end

  def inactive_message
    'Your account has been disabled!'
  end

  def ensure_authentication_token
    self.auth_token = generate_authentication_token if auth_token.blank?
  end

  def generate_authentication_token!
    self.auth_token = Devise.friendly_token if
    self.class.exists?(auth_token: auth_token)
  end
end
