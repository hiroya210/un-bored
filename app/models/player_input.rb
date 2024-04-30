class PlayerInput < ApplicationRecord
  belongs_to :player
  belongs_to :instance
  # belongs_to :round
  # validates :type, presence: true, inclusion: { in: %w[string boolean integer] } # can be modified later
  validates :input_value, presence: true
  validates :player_id, presence: true, uniqueness: { scope: :round_id }
end
