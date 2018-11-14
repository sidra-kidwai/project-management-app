# frozen_string_literal: true

module ActiveAdmin::ProjectsHelper
  def attachment_hint(attachment)
    if attachment.object.file.present?
      content_tag(:span, 'no file yet')
    else
      image_tag(attachment.object.url(:thumb))
    end
  end
end
