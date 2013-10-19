class AddEloToUsers < ActiveRecord::Migration
  def change
    add_column :users, :elo, :integer, :null => false, :default => 1200
  end
end
