class RemoveImageFromProductionData < ActiveRecord::Migration[5.2]
  def change
    remove_column :production_data, :image, :string
  end
end
