class CreateBlocks < ActiveRecord::Migration[6.1]
  def change
    create_table :blocks do |t|
      t.integer :blocked_by_id
      t.integer :blocked_id

      t.timestamps
    end
    add_index :blocks, :blocked_by_id
    add_index :blocks, :blocked_id
    add_index :blocks, [:blocked_by_id, :blocked_id], unique: true
  end
end
