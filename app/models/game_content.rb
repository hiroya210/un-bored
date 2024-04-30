class GameContent < ApplicationRecord
  has_many :rounds
  validates :content, presence: true
end
