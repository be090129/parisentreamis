class Ligue < ActiveRecord::Base
  belongs_to :tournament
  has_many :pronostics, dependent: :destroy

  has_many :members
  has_many :users, :through => :members,  dependent: :destroy

end
