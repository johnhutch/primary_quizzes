module EloMath
  def update_elo(other_elo, success)
    # Store the current elo of model
    current_elo = self.elo
    expected_score = 0
    elo_change = 0
    score_difference = other_elo - current_elo

    # Set to 1 if success is true, 0 if success is false
    actual_score = success ? 1 : 0

    # Default seems to be 400 everywhere in the ELO world, also known as F Factor
    rating_disparity = 400

    # Also known as K Factor, and is based on the ELOs of the parties involved
    match_importance = 16
    if(current_elo < 2400 || other_elo < 2400)
      match_importance = 24
    end
    if(current_elo < 2100 || other_elo < 2100)
      match_importance = 32
    end
  end
end