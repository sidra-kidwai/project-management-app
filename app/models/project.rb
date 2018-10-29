class Project < ApplicationRecord
  belongs_to :client
  has_many :project_users
  has_many :users, through: :project_users, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy

  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true
end
