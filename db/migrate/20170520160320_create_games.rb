class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.date :date_played_at
      t.integer :opponent_id
      t.integer :your_score
      t.integer :their_score
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
