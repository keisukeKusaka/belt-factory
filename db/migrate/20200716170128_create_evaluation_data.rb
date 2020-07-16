class CreateEvaluationData < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluation_data do |t|
      t.text       :comment, null: false
      t.string     :image
      t.references :product, foreign_key: true
      t.references :user,    foreign_key: true
      t.timestamps
    end
  end
end
