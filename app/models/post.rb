class Post < ApplicationRecord
  belongs_to :user
  # active storage
  has_one_attached :thumbnail
  has_one_attached :banner
  #action text
  has_rich_text :body
  validates :title, length: {minimum: 5, maximum: 125}
  def optimized_image(image,x,y)
    return image.variant(resize_to_fill: [x,y]).processed
  end
end