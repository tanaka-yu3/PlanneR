class Photo < ApplicationRecord
  belongs_to :review
  belongs_to :item
  attachment :image
end
