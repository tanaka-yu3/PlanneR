class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :image
  has_many :items ,dependent: :destroy
  has_many :reviews ,dependent: :destroy
  has_many :favorites ,dependent: :destroy
  has_many :orders ,dependent: :destroy

  ##フォロー機能
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed, source: :follower

  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    following_user.include?(user)
  end

  ##googleログイン機能
  devise :trackable, :omniauthable, omniauth_providers: %i(google)
  protected
  def self.find_for_google_oauth2(auth)

  ##登録済のUSER
  user = User.find_by(email: auth.info.email)

  ##新規登録のUSER
  unless user
  user = User.create(family_name: auth.info.name,
                     email: auth.info.email,
                     provider: auth.provider,
                     uid:      auth.uid,
                     token:    auth.credentials.token,
                     password: Devise.friendly_token[0, 20],
                     meta:     auth.to_yaml)
  end
  user
  end

  #バリデーション
  validates :family_name, presence: true

end
