class Post < ApplicationRecord
  belongs_to :user
  attachment :image
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :cook_name, presence: true
  validates :image, presence: true

  # favorited_by?メソッドで、引数で渡されたユーザidがFavoritesテーブル内に存在（exists?）するかどうかを調べる
  # 存在していればtrue、存在していなければfalseを返すようにしています。
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  def self.search_for(content, method)
    if method == "perfect"
      Post.where(cook_name: content)
    elsif method == "forward"
      Post.where("cook_name LIKE ?", content +"%")
    elsif method == "backward"
      Post.where("cook_name LIKE ?", "%" + content)
    else
      Post.where("cook_name LIKE ?", "%" + content + "%")
    end
  end
end

