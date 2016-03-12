class Team < ActiveRecord::Base
  belongs_to :tournament
  has_many :players, dependent: :destroy
  accepts_nested_attributes_for :players, :allow_destroy => true

  has_many :bets

  has_attached_file :avatar, styles: {
      thumb: '40x100>',
      square: '80x200#',
      medium: '160x400>'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

end
