class Genre < ApplicationRecord
  
  belongs_to :item
  validates :name,presence:true
  
end
