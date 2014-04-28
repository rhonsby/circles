class CreateCircleMemberships < ActiveRecord::Migration
  def change
    create_table :circle_memberships do |t|
      t.integer :friend_circle_id, null: false
      t.integer :friend_id, null: false

      t.timestamps
    end

    add_index :circle_memberships, :friend_circle_id
    add_index :circle_memberships, [:friend_circle_id, :friend_id], unique: true
  end
end