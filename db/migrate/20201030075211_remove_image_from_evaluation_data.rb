class RemoveImageFromEvaluationData < ActiveRecord::Migration[5.2]
  def change
    remove_column :evaluation_data, :image, :string
  end
end
