class Instance < ApplicationRecord
  belongs_to :game
  belongs_to :user # host
  has_many :players, dependent: :destroy
  has_many :player_inputs, dependent: :destroy
  has_many :rounds, dependent: :destroy

  validates :status, presence: true, inclusion: { in: ['waiting', 'ongoing', 'done'] }
  validates :max_rounds, :max_players, presence:true, numericality: { greater_than_or_equal_to: 2 }
  validates_uniqueness_of :passcode, conditions: -> { where(status: 'waiting') }

  enum status: { waiting: 'waiting', ongoing: 'ongoing', done: 'done' }
end
