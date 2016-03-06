class Tournament < ActiveRecord::Base

  has_many :teams, dependent: :destroy
  accepts_nested_attributes_for :teams, :allow_destroy => true

  has_many :bets, dependent: :destroy
  accepts_nested_attributes_for :bets, :allow_destroy => true

  has_many :teams

end
