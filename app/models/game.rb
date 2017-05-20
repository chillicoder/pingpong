require 'ranker'

class Game < ActiveRecord::Base
  belongs_to :user

  validates :your_score, numericality: { integer: true, greater_than: 0, less_than_or_equal_to: 21 }
  validates :their_score, numericality: { integer: true, greater_than: 0, less_than_or_equal_to: 21 }

  validate :two_point_difference

  def two_point_difference
    difference = (your_score - their_score).abs
    if difference < 2
      errors.add(:base, 'The difference must be at least 2 pts.')
    end
  end

  after_save do
    user.score += your_score
    user.games_played += 1
    user.save!

    opponent = User.find(opponent_id)
    opponent.score += their_score
    opponent.games_played += 1
    opponent.save!
    
    # update ranking
    winner = user
    loser = opponent

    if user.score >= 21 
      winner = user
      loser = opponent
    else
      winner = opponent
      loser = user
    end

    ranker = Ranker.new(winner.rank, loser.rank, -1)
    result = ranker.calculate

    winner.rank = result[0]
    loser.rank = result[1]

    winner.save!
    loser.save!
  end
end
