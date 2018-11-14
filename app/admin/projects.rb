# frozen_string_literal: true

ActiveAdmin.register Project do
  permit_params :name, :details, :client_id, :user_ids,
                attachments_attributes: %i[id file _destroy]

  form do |f|
    f.semantic_errors(*f.object.errors.keys)
    f.inputs 'Details' do
      f.input :name
      f.input :details
      f.input :client_id, as: :select, collection: Client.pluck(:name, :id),
                          include_blank: 'Select Client'
      f.input :user_ids, label: 'Users', as: :select,
                         collection: User.user.pluck(:name, :id),
                         input_html: { class: 'chosen-select', multiple: true }
    end
    f.has_many :attachments, allow_destroy: true do |attachment|
      attachment.input :file, as: :file, hint: attachment_hint(attachment)
    end
    f.actions
  end
end
