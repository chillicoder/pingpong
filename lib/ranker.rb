class Ranker
  def initialize(player_1_rank, player_2_rank, result)
    @player_1_rank = player_1_rank
    @player_2_rank = player_2_rank
    @result = result
  end

  def calculate
    difference = (@player_1_rank - @player_2_rank).abs
    case @result
    when -1
      # player 1 won
      new_p1_rank = @player_1_rank - difference
      new_p1_rank = 1 if new_p1_rank < 1
      new_p2_rank = @player_2_rank + difference + 1
    when 0
      # draw
    when 1
      # player 2 won
      new_p2_rank = @player_2_rank - difference
      new_p2_rank = 1 if new_p2_rank < 1
      new_p1_rank = @player_1_rank + difference + 1
    end
    return [new_p1_rank, new_p2_rank]
  end
end
