class Team < ActiveRecord::Base
  belongs_to :tournament
  has_many :players, dependent: :destroy
  accepts_nested_attributes_for :players, :allow_destroy => true

  has_many :bets

  has_attached_file :avatar, styles: {
      mini: '50x30>',
      thumb: '100x60>',
      square: '200x120>',
      medium: '400x240>'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

end
