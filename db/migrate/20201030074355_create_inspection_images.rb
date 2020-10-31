class CreateInspectionImages < ActiveRecord::Migration[5.2]
  def change
    create_table :inspection_images do |t|
      t.string     :image, null: false
      t.references :inspection_datum, foreign_key: true
      t.timestamps
    end
  end
end
