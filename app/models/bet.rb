class Bet < ActiveRecord::Base
  belongs_to :tournament
  belongs_to :equipe1, :class_name => 'Team', :foreign_key => 'equipe1_id'
  belongs_to :equipe2, :class_name => 'Team', :foreign_key => 'equipe2_id'
end
