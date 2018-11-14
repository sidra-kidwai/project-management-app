# frozen_string_literal: true

class Attachment < ApplicationRecord
  has_attached_file :file,
                    styles: {
                      medium: '300x300>',
                      thumb: '100x100>'
                    },
                    default_url: '/assets/:style/dummy_image.jpeg'

  belongs_to :attachable, polymorphic: true

  validates :file, attachment_presence: true
  validates_with AttachmentPresenceValidator, attributes: :file
  validates_attachment_content_type :file, content_type: %r{/\Aimage\/.*\z/}
  validates_with AttachmentSizeValidator, attributes: :file,
                                          less_than: 1.megabytes

  def url(style = :medium)
    file.url(style)
  end
end
