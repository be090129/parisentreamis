class Bet < ActiveRecord::Base
  belongs_to :tournament
  belongs_to :equipe1, :class_name => 'Team', :foreign_key => 'equipe1_id'
  belongs_to :equipe2, :class_name => 'Team', :foreign_key => 'equipe2_id'
  has_many :pronostics, dependent: :destroy


  def is_finished
    !(score1.blank? && score2.blank?)
  end

  def is_start
    start_at < DateTime.now
  end

  def score_final
    score1.to_s + "-" + score2.to_s
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

  def pronosticated_by_user(user, ligue)
    if user
      old_pronostic=Pronostic.where("user_id = ? AND ligue_id = ? AND bet_id = ?",user.id,ligue.id, id).first
    end
  end



end
