# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true
      t.text :content, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
