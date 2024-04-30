class Round < ApplicationRecord
  belongs_to :instance
  has_many :player_inputs

  # numericality is to only accept positive values
  validates :number, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :game_content_id, uniqueness: { scope: :instance_id }
end
