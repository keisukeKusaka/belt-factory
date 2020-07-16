class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :campany, null: false
      t.timestamps
    end

    add_index :clients, :campany, unique: true
  end
end
