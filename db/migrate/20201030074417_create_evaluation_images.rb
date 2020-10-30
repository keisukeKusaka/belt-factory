class CreateEvaluationImages < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluation_images do |t|
      t.string     :image, null: false
      t.references :evaluation_datum, foreign_key: true
      t.timestamps
    end
  end
end
