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
end
