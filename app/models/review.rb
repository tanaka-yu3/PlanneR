class Review < ApplicationRecord
  belongs_to :users
  has_many :photos ,dependent: :destroy
end
