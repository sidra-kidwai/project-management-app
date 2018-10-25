module UsersHelper
  def user_image_tag user, size
    if user.attachment.present?
      image_tag(user.attachment.file.url, size: size, class: "img-circle", alt: user.name) if user.attachment.persisted?
    else
      image_tag(image_path('dummy_image.jpeg'), class: "img-circle", alt: user.name , size: size)
    end
  end
end
