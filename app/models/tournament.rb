class Tournament < ActiveRecord::Base
  has_many :teams, dependent: :destroy
  accepts_nested_attributes_for :teams, :allow_destroy => true
end
