class AddPositionToCeramiques < ActiveRecord::Migration[5.2]
  def change
    add_column :ceramiques, :position, :integer
  end
end
