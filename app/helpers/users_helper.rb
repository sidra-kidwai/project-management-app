# frozen_string_literal: true

module UsersHelper
  def user_image_tag(user, size)
    if user.attachment&.persisted?
      image_tag(user.attachment.url, size: size, class: 'img-circle', alt: user.name)
    else
      image_tag(image_path('dummy_image.jpeg'), class: 'img-circle', alt: user.name, size: size)
    end
  end
end
