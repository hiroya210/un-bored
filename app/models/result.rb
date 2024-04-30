class Result < ApplicationRecord
  belongs_to :instance

  has_one_attached :photo, dependent: :destroy
end
