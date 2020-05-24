class Photo < ApplicationRecord
  belongs_to :item
  attachment :image

  validates :image ,presence: true
end
