class CreateInspectionData < ActiveRecord::Migration[5.2]
  def change
    create_table :inspection_data do |t|
      t.float      :length,  null: false
      t.integer    :width,   null: false
      t.float      :weight,  null: false
      t.text       :comment, null: false
      t.string     :image
      t.references :product, foreign_key: true
      t.references :user,    foreign_key: true
      t.timestamps
    end
  end
end
