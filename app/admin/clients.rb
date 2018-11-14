# frozen_string_literal: true

ActiveAdmin.register Client do
  permit_params :name,
                :description,
                projects_attributes: [
                  :id, :name, :details, :_destroy,
                  attachments_attributes: %i[id file _destroy]
                ]
  form do |f|
    f.semantic_errors(*f.object.errors.keys)
    f.inputs 'Details' do
      f.input :name
      f.input :description
    end
    f.has_many :projects, allow_destroy: true do |project|
      project.input :name
      project.input :details
      project.has_many :attachments, allow_destroy: true do |attachment|
        attachment.input :file, as: :file, hint: attachment_hint(attachment)
      end
    end
    f.actions
  end
end
