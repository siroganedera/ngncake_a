class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items
  has_many :order_details
  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :introduction
    validates :price
  end

  def get_image
    (image.attached?) ? image : 'no-image-icon.jpg'
  end

  def index
    @items = Item.search(params[:search]).page(params[:page]).order(created_at: 'desc')
  end

  def add_tax_price
    (self.price * 1.10).round
  end
end
