class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string     :number,   null: false
      t.float      :length,   null: false
      t.integer    :width,    null: false
      t.references :client,   foreign_key: true
      t.references :material, foreign_key: true
      t.references :user,     foreign_key: true

      t.timestamps
    end
    add_index :products, :number,unique: true, length: { is: 6 }
  end
end
