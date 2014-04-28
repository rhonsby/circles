class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url, null: false
      t.integer :post_id, null: false
      t.string :name, null: false

      t.timestamps
    end

    add_index :links, :post_id
  end
end
