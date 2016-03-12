class Ligue < ActiveRecord::Base
  belongs_to :tournament
  has_many :pronostics

  has_many :members
  has_many :users, :through => :members,  dependent: :destroy

end
