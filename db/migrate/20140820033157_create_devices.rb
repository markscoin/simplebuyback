class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :type
      t.string :brand
      t.string :model
      t.string :carrier
      t.integer :price
      t.string :condition
      t.string :memorysize
      t.string :name
      t.boolean :buying

      t.timestamps
    end
  end
end
