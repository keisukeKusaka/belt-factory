class RemoveImageFromInspectionData < ActiveRecord::Migration[5.2]
  def change
    remove_column :inspection_data, :image, :string
  end
end
