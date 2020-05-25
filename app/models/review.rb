class Review < ApplicationRecord
  belongs_to :item
  belongs_to :user

  validates :text ,presence: true
  validates :rate ,presence: true
end