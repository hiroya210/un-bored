class Vote < ApplicationRecord
  belongs_to :instance
  belongs_to :voter, class_name: 'Player'
  belongs_to :voted_player, class_name: 'Player'
end
