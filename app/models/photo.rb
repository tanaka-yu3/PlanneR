class Photo < ApplicationRecord
  belongs_to :item
  attachment :image
end
