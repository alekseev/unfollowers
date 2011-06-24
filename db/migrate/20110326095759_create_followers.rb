class CreateFollowers < ActiveRecord::Migration
  def self.up
    create_table :followers do |t|
      t.integer :twitter_id
      t.integer :user_id
      t.integer :followers
      t.integer :following
      t.integer :tweets
      t.string :name
      t.string :screen_name
      t.string :image
      t.string :description
      t.boolean :new, :default => true
      t.timestamps
    end
  end

  def self.down
    drop_table :followers
  end
end
