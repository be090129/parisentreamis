class Ligue < ActiveRecord::Base
  belongs_to :tournament
  has_many :pronostics
end
