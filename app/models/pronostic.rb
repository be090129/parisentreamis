class Pronostic < ActiveRecord::Base
  belongs_to :user
  belongs_to :bet, dependent: :destroy
  belongs_to :ligue, dependent: :destroy

  validates :score1,:score2,:bet_id, :presence => true
  validates_numericality_of :score1,:score2, :only_integer => true, :greater_than_or_equal_to => 0

  def win?
    score1==bet.score1 && score2==bet.score2
  end

  def score_prono
    score1.to_s+"-"+score2.to_s
  end

  def loose?
    bet.is_finished && !win?
  end


  def global_result
    if score1==score2
      "match_nul"
    elsif score1>score2
      "equipe1"
    else
      "equipe2"
    end
  end

  def global_win?
    bet.global_result==global_result
  end


end
