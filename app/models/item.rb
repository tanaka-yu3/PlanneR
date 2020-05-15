class Item < ApplicationRecord

  enum item_status:{permitting: 0 , release: 1, expired: 2 , stopping: 3 }

  belongs_to :user
  belongs_to :genre

  has_many :photos ,dependent: :destroy
  accepts_attachments_for :photos, attachment: :image, append: true

  has_many :reviews ,dependent: :destroy
  has_many :orders ,dependent: :destroy

  has_many :favorites ,dependent: :destroy
  def favorited_by?(user)
  	favorites.where(user_id: user.id).exists?
  end
end
