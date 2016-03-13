class Tournament < ActiveRecord::Base

  has_many :teams

  has_many :bets, dependent: :destroy
  accepts_nested_attributes_for :bets, :allow_destroy => true

  has_many :ligues, dependent: :destroy

  scope :is_open, -> { where('start_date <= ? AND end_date >= ?', Date.today, Date.today) }


end
