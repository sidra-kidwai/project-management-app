# frozen_string_literal: true

class CreateAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :attachments do |t|
      t.string :file
      t.string :attachable_type, null: false
      t.integer :attachable_id, null: false

      t.timestamps
    end

    add_index :attachments, %i[attachable_type attachable_id]
  end
end
