class CreateGamePermissions < ActiveRecord::Migration
  def self.up
    create_table :game_permissions do |t|
      t.integer :user_id
      t.integer :game_id
      t.boolean :accepted
      t.boolean :admin
      t.string :api_key, :limit => 40
      t.timestamps
    end
  end

  def self.down
    drop_table :game_permissions
  end
end
