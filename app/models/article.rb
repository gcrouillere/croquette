class Article < ApplicationRecord
  belongs_to :user

  validates :name, presence: :true
  validates :title, presence: { if: -> { self.name == "article" } }
  validates :content, presence: { if: -> { self.name == "article" } }

  has_attachment :article_main_photo

end
