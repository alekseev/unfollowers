class AddColumnsToUser < ActiveRecord::Migration
  def self.up
  	add_column :users, :mail_period, :string, :default => "hour"
  	add_column :users, :mail_sent, :datetime
  end

  def self.down
  	remove_column :users, :mail_period
  	remove_column :users, :mail_sent
  end
end
