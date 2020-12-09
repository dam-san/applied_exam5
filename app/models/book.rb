class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments
  has_many :favorites
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }


  def dareka_favoshiteru?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search_for(content, method)
    if method == 'perfect'
      Book.where(title: content)
    else
      Book.where('title LIKE ?', '%'+content+'%')
    end
  end


end
