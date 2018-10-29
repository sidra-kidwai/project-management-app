class Attachment < ApplicationRecord
  has_attached_file :file,
                    styles: {
                      medium: "300x300>",
                      thumb: "100x100>"
                    },
                    default_url: "/images/:style/dummy_image.jpeg"

  belongs_to :attachable, polymorphic: true

  validates :file, attachment_presence: true
  validates_with AttachmentPresenceValidator, attributes: :file
  validates_attachment_content_type :file, content_type: /\Aimage\/.*\z/
  validates_with AttachmentSizeValidator, attributes: :file, less_than: 1.megabytes

  def url(style = :medium)
    self.file.url(style)
  end

end
