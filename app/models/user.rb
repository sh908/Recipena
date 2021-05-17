class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :profile_image

  # 自分がフォローされる（被フォロー）側の関係性
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  # 自分がフォローする（与フォロー）側の関係性
  has_many :relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed

  def follow(user_id)
    # createメソッドはnewとsaveを合わせた挙動
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    # find_byによって1レコードを特定し、destroyメソッドで削除
    relationships.find_by(followed_id: user_id).destroy
  end

  def followings?(user)
    followings.include?(user)
  end

  # ログインする時に退会済み(is_deleted==true)のユーザーを弾くためのメソッド
  # userのis_deletedがfalseならtrueを返す
  def active_for_authentication?
    super && (is_deleted == false)
  end
  
  def self.search_for(content, method)
    if method == "perfect"
      User.where(name: content)
    elsif method == "forward"
      User.where("name LIKE ?", content + "%")
    elsif method == "backward"
      User.where("name LIKE ?", "%" + content)
    else 
      User.where("name LIKE ?", "%" + content + "%")
    end
  end 
end
