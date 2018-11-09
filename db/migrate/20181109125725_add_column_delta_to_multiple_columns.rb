class AddColumnDeltaToMultipleColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :delta, :boolean, default: true, null: false
    add_column :projects, :delta, :boolean, default: true, null: false
    add_column :clients, :delta, :boolean, default: true, null: false
  end
end
