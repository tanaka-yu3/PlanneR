class Item < ApplicationRecord

  enum item_status:{permitting: 0 , release: 1, expired: 2 , stopping: 3 }

 #アソシエーション
  belongs_to :user
  belongs_to :genre
  has_many :photos ,dependent: :destroy
  accepts_attachments_for :photos, attachment: :image, append: true
  has_many :orders ,dependent: :destroy
  has_many :reviews ,dependent: :destroy
  has_many :favorites ,dependent: :destroy
  def favorited_by?(user)
  	favorites.where(user_id: user.id).exists?
  end


  #バリデーション
  validates :name ,presence: true
  validates :text ,length: { minimum: 20 }
  validates :address ,presence: true
  validates :total ,presence: true
  validates :start_day ,presence: true
  validates :finish_day ,presence: true
  validate :date_before_start
  validate :date_before_finish

  def date_before_start
    return if start_day.blank?
    errors.add(:start_day, "は今日以降のものを選択してください") if start_day < Date.today && !id
  end

  def date_before_finish
    return if finish_day.blank? || start_day.blank?
    errors.add(:finish_day, "は開始日以降のものを選択してください") if finish_day < start_day && !id
  end

end