class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.decimal :amount, precision: 5, scale: 2
      t.datetime :payment_date, null: false
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
