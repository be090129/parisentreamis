class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :pronostics,  dependent: :destroy
  has_many :members,  dependent: :destroy
  has_many :ligues, :through => :members


end
