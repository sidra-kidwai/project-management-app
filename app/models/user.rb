class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :attachment, as: :attachable, dependent: :destroy

  validates :name, presence: true

  accepts_nested_attributes_for :attachment, allow_destroy: true

  def fetch_attachment
    self.attachment.nil? ? self.build_attachment : self.attachment
  end
end
