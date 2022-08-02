class CreateTeaCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :tea_customers do |t|
      t.string :title
      t.integer :price
      t.column :status, :integer, default: 0
      t.column :frequency, :integer, default: 0
      t.references :customer, foreign_key: true
      t.references :tea, foreign_key: true

      t.timestamps
    end
  end
end
