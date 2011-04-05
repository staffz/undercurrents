class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.string :name
      t.string :domain
      t.string :api_key,  :limit => 40
      t.integer :owner_id

      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
