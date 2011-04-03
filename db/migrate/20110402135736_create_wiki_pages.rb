class CreateWikiPages < ActiveRecord::Migration
  def self.up
    create_table :wiki_pages do |t|
      t.string :url
      t.text :content
      t.integer :version
      t.integer :game_id

      t.timestamps
    end
  end

  def self.down
    drop_table :wiki_pages
  end
end
