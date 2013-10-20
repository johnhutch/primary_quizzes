class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :choices

  accepts_nested_attributes_for :choices

  def update_elo(other_elo, success)

    # Set to 1 if success is true, 0 if success is false
    actual_score = success ? 1 : 0

    # Default seems to be 400 everywhere in the ELO world, also known as F Factor
    rating_disparity = 400

    # Also known as K Factor, and is based on the ELOs of the parties involved
    match_importance = 16
    if(self.elo < 2400 || other_elo < 2400)
      match_importance = 24
    end
    if(self.elo < 2100 || other_elo < 2100)
      match_importance = 32
    end

    expected_score = 1 / (1 + 10**((other_elo - self.elo) / rating_disparity))

    self.elo = self.elo + match_importance * (actual_score - expected_score)

    if self.elo < 100
      self.elo = 100
    end

    self.save

  end

  def check_for_solution(solver, choice)
    solver_elo = solver.elo
    question_elo = self.elo

    # User got the question right
    if (self.solution_id == choice.id)

      # User won against question
      solver.update_elo(question_elo, true)

      # Question lost to user
      self.update_elo(solver_elo, false)

      return true

    # User did NOT get the question right
    else

      # User lost to question
      solver.update_elo(question_elo, false)

      # Question won against user
      self.update_elo(solver_elo, true)

      return false
    end

  end

end