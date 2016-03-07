class Bet < ActiveRecord::Base
  belongs_to :tournament
  belongs_to :equipe1, :class_name => 'Team', :foreign_key => 'equipe1_id'
  belongs_to :equipe2, :class_name => 'Team', :foreign_key => 'equipe2_id'

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

=begin
  def pronosticated_by_user(user)
    if user && !user.is_admin
        old_pronostic=Pronostic.where("user_id = ? AND match_id = ?",user.id,id).first
    end
  end
=end



end
