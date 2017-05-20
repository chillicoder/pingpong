class AddRankingToUser < ActiveRecord::Migration
  def change
    add_column :users, :rank, :integer, default: 1
    add_column :users, :score, :integer, default: 0
    add_column :users, :games_played, :integer, default: 0
  end
end
