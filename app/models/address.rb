class Address < ApplicationRecord
  
  
  #「郵便番号 住所 宛名」を表示させるために取り出すためのもの
  def address_display
  '〒' + postal_code + ' ' + address + ' ' + name
  end
  
end
