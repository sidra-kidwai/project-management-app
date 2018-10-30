module ActiveAdmin::ProjectsHelper
  def attachment_hint(attachment)
    attachment.object.file.present? ? image_tag(attachment.object.url(:thumb)) : content_tag(:span, "no file yet")
  end
end
