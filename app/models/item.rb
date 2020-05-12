class Item < ApplicationRecord
  belongs_to :user
  belongs_to :genre

  has_many :photos ,dependent: :destroy
  accepts_attachments_for :photos, attachment: :image
  has_many :favorites ,dependent: :destroy
  has_many :reviews ,dependent: :destroy
  has_many :orders ,dependent: :destroy
end
