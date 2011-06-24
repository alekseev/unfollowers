class AddValidationCodeToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :validation_code, :string
    add_column :users, :email_validated, :boolean, :default => false
  end

  def self.down
    remove_column :users, :validation_code
    remove_column :users, :email_validated
  end
end