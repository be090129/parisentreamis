class Team < ActiveRecord::Base
  belongs_to :tournament
  has_many :players, dependent: :destroy
  accepts_nested_attributes_for :players, :allow_destroy => true

  has_many :bets

end
