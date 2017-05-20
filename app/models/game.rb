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
  end
end
