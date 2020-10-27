class CreateProductionImages < ActiveRecord::Migration[5.2]
  def change
    create_table :production_images do |t|
      t.string     :image, null: false
      t.references :production_datum, foreign_key: true
      t.timestamps
    end
  end
end
