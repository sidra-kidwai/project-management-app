class RemoveFileFromAttachments < ActiveRecord::Migration[5.2]
  def change
    remove_column :attachments, :file, :string
  end
end
