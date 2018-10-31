class Payment < ApplicationRecord
  belongs_to :project
  delegate :client, to: :project
end
